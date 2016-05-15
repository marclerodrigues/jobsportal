class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text :title
      t.text :salary
      t.text :type
      t.text :description
      t.text :about
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
