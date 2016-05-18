class ChangeColumnTypeSkill < ActiveRecord::Migration
  def change
    remove_column :skills, :years
    add_column :skills, :years, :decimal
  end
end
