class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.text :address
      t.string :phone
      t.string :email
      t.boolean :active

      t.timestamps
    end
  end
end
