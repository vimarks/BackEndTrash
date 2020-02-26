class AddCleanerIdToReputations < ActiveRecord::Migration[6.0]
  def change
    add_column :reputations, :cleaner_id, :int
  end
end
