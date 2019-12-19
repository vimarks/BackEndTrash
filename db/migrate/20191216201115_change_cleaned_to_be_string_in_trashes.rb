class ChangeCleanedToBeStringInTrashes < ActiveRecord::Migration[6.0]
  def change
    change_column :trashes, :cleaned, :string
  end
end
