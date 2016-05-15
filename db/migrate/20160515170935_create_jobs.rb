class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text :title
      t.text :salary
      t.text :job_type
      t.text :description
      t.text :about
      t.references :company, index: true, foreign_key: true
    end
  end
end
