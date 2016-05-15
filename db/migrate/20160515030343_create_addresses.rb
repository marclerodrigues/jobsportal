class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :street
      t.text :city
      t.text :state
      t.text :zip_cep

      t.timestamps null: false
    end
  end
end
