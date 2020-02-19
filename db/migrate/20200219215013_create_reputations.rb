class CreateReputations < ActiveRecord::Migration[6.0]
  def change
    create_table :reputations do |t|
      t.integer :user_id
      t.float :rating

      t.timestamps
    end
  end
end
