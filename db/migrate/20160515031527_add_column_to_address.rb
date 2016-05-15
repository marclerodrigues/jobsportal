class AddColumnToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :candidate, index: true, foreign_key: true
  end
end
