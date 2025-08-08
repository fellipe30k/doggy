class CreateOwners < ActiveRecord::Migration[8.0]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.references :user, null: true, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
