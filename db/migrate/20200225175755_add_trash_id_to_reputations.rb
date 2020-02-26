class AddTrashIdToReputations < ActiveRecord::Migration[6.0]
  def change
    add_column :reputations, :trash_id, :int
  end
end
