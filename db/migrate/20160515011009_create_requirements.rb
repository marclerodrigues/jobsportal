class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.text :title
      t.integer :years
      t.references :job, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
