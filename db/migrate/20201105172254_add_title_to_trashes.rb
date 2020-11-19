class AddTitleToTrashes < ActiveRecord::Migration[6.0]
  def change
    add_column :trashes, :title, :string
  end
end
