class RemoveColumnCandidateMatchAddMatch < ActiveRecord::Migration
  def change
    remove_column :applications, :candidate_match
    add_column :applications, :match, :decimal
  end
end
