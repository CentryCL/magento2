# frozen_string_literal: true

require 'net/http'
require 'net/https'
require 'json'

class Magento2

  attr_reader :host, :username, :password
  attr_accessor :access_token

  def initialize(host, username, password)
    @host = host
    @username = username
    @password = password
  end

  def get(endpoint, params = {})
    request(endpoint, :get, params)
  end

  def post(endpoint, params = {}, payload = {})
    request(endpoint, :post, params, payload)
  end

  def put(endpoint, params = {}, payload = {})
    request(endpoint, :put, params, payload)
  end

  def delete(endpoint, params = {})
    request(endpoint, :delete, params, payload)
  end

  def admin_token
    payload = { username: @username, password: @password }

    @access_token = request(
      '/rest/V1/integration/admin/token', :post, nil, payload, false
    ).body.gsub('"', '')
  end

  def request(endpoint, method, params = {}, payload = {}, token_needed = true)
    query = params ? URI.encode_www_form(params) : ''
    uri = URI("#{@host}#{endpoint}?#{query}")
    req = net_http_request(method, uri)
    req.add_field('Content-Type', 'application/json')
    req.add_field('Authorization', "Bearer #{@access_token}") if token_needed

    req.body = JSON.generate(payload) if payload && payload != {}
    Net::HTTP.start(
      uri.hostname, uri.port, use_ssl: @host.start_with?('https')
    ) { |http| return http.request(req) }
  end

  private

  def net_http_request(method, uri)
    case method
    when :get    then Net::HTTP::Get.new(uri)
    when :post   then Net::HTTP::Post.new(uri)
    when :put    then Net::HTTP::Put.new(uri)
    when :delete then Net::HTTP::Delete.new(uri)
    else
      raise 'HTTP method not supported'
    end
  end

end
