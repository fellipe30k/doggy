json.extract! owner, :id, :name, :email, :phone, :user_id, :company_id, :created_at, :updated_at
json.url owner_url(owner, format: :json)
