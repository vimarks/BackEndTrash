class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.integer :balance

      t.timestamps
    end
  end
end
