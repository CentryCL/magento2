# frozen_string_literal: true

require 'minitest/autorun'
require 'cgi'
require 'magento2'

class Magento2Test < Minitest::Test

  def setup
    host = 'https://www.example.com'
    username = 'username'
    password = 'password'
    @sdk = Magento2.new(host, username, password)
  end

  def test_admin_token
    # test_admin_token
    assert_instance_of String, @sdk.admin_token

    # test_list_products
    resp = @sdk.get('/rest/V1/products', searchCriteria: 10)
    assert_equal '200', resp.code
    assert JSON.parse(resp.body).length >= 0
  end

end
