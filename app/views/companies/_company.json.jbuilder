json.extract! company, :id, :name, :cnpj, :address, :phone, :email, :active, :created_at, :updated_at
json.url company_url(company, format: :json)
