class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.integer :quantity
      t.date :timestamp
      t.belongs_to :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
