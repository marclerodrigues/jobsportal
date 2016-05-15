class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.text :title
      t.integer :years
      t.references :candidate, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
