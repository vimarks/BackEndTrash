class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :type
      t.string :URL
      t.integer :trash_id

      t.timestamps
    end
  end
end
