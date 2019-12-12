class AddReporterIdToTrashes < ActiveRecord::Migration[6.0]
  def change
    add_column :trashes, :reporter_id, :integer
  end
end
