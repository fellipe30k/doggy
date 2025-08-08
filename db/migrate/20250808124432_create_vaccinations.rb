class CreateVaccinations < ActiveRecord::Migration[8.0]
  def change
    create_table :vaccinations do |t|
      t.references :animal, null: false, foreign_key: true
      t.string :vaccine_name
      t.string :vaccine_brand
      t.date :application_date
      t.date :next_dose_date
      t.string :veterinarian_name
      t.string :batch_number
      t.text :observations
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
