class CreateTrashes < ActiveRecord::Migration[6.0]
  def change
    create_table :trashes do |t|
      t.integer :bounty
      t.integer :location_id
      t.integer :user_id
      t.boolean :cleaned
      t.string :description

      t.timestamps
    end
  end
end
