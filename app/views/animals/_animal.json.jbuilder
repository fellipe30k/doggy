json.extract! animal, :id, :name, :species, :breed, :birth_date, :weight, :color, :microchip, :user_id, :company_id, :owner_name, :owner_phone, :owner_email, :created_at, :updated_at
json.url animal_url(animal, format: :json)
