json.array!(@emails) do |email|
  json.extract! email, :user_id, :subject, :content
  json.url email_url(email, format: :json)
end
