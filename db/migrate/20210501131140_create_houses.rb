class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.float :price
      t.text :details
      t.string :about
      t.string :picture
      t.string :owner

      t.timestamps
    end
  end
end
