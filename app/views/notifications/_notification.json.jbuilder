json.extract! notification, :id, :title, :message, :kind, :user_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
