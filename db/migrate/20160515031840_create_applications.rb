class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :candidate, index: true, foreign_key: true
      t.references :job, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.float :candidate_match

      t.timestamps null: false
    end
  end
end
