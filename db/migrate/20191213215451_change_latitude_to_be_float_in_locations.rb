class ChangeLatitudeToBeFloatInLocations < ActiveRecord::Migration[6.0]
  def change
    change_column :locations, :latitude, :float
  end
end
