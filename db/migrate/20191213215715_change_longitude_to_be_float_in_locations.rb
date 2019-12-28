class ChangeLongitudeToBeFloatInLocations < ActiveRecord::Migration[6.0]
  def change
    change_column :locations, :longitude, :float
  end
end
