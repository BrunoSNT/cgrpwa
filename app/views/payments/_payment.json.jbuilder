json.extract! payment, :id, :project_id, :value, :payment_date, :created_at, :updated_at
json.url payment_url(payment, format: :json)
