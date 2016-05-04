class CreateTradeins < ActiveRecord::Migration
  def change
    create_table :tradeins do |t|
      t.string :user_id
      t.string :book_id

      t.timestamps null: false
    end
  end
end
