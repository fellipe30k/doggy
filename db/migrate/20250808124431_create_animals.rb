class CreateAnimals < ActiveRecord::Migration[8.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :species
      t.string :breed
      t.date :birth_date
      t.decimal :weight
      t.string :color
      t.string :microchip
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :owner_name
      t.string :owner_phone
      t.string :owner_email

      t.timestamps
    end
  end
end
