json.array!(@subscriptions) do |subscription|
  json.extract! subscription, 
  json.url subscription_url(subscription, format: :json)
end
