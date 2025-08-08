class AddOwnerToAnimals < ActiveRecord::Migration[8.0]
  def change
    add_reference :animals, :owner, null: false, foreign_key: true
  end
end
