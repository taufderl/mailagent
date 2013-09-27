json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :user_id, :list_id
  json.url subscription_url(subscription, format: :json)
end
