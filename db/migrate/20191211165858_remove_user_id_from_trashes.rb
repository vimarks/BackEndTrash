class RemoveUserIdFromTrashes < ActiveRecord::Migration[6.0]
  def change

    remove_column :trashes, :user_id, :integer
  end
end
