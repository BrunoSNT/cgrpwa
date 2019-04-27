json.extract! deal, :id, :deal_date, :client_name, :client_company, :sector, :sector_description, :problems, :address, :website, :telephone1, :telephone2, :email, :info, :arrival, :created_at, :updated_at
json.url deal_url(deal, format: :json)
