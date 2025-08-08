json.extract! vaccination, :id, :animal_id, :vaccine_name, :vaccine_brand, :application_date, :next_dose_date, :veterinarian_name, :batch_number, :observations, :user_id, :company_id, :created_at, :updated_at
json.url vaccination_url(vaccination, format: :json)
