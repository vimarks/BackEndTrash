class AddCleanerIdToTrashes < ActiveRecord::Migration[6.0]
  def change
    add_column :trashes, :cleaner_id, :integer
  end
end
