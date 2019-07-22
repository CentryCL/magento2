# Magento2 Ruby SDK
The Magento's Ruby SDK is a small and no dependency gem that allows you to do
any kind of request to the Magento 2's API

## Before start

Add it to your Gemfile:

```ruby
gem 'magento2', github: 'centrycl/magento2'
```

And then install

```
bundle install
```

## How do I use it?

### Create an instance of Magento2 class

```ruby
sdk = Magento2.new('host', 'username', 'password')
# Refhresh the access token
sdk.admin_token
```

### GET

```ruby
# List products
resp = sdk.get('/rest/V1/products', searchCriteria: 10)
if resp.code == 200
  products = JSON.parse(resp.body)
end

# One product
product = JSON.parse(sdk.get('/rest/V1/products/1', searchCriteria: nil).body)
```

### POST

```ruby
product = {
  # Your product info
}
resp = sdk.post('/rest/V1/products', nil, product)
if resp.code == 200
  # All right
end
```

### PUT

```ruby
product = {
  # Your product info
}
resp = sdk.put('/rest/V1/products/', searchCriteria: nil, product)
if resp.code == 200
  # All right
end
```

### DELETE

```ruby
resp = sdk.delete('/rest/V1/products/1')
if resp.code == 200
  # Product deleted
end
```