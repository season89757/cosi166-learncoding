class Sample < ActiveRecord::Migration
  def change
    change_column :likes, :user_id, :integer
    change_column :likes, :book_id, :integer
    change_column :messages, :book_id, :integer
    change_column :tradeins, :user_id, :integer
    change_column :tradeins, :book_id, :integer
    change_column :tradeoffs, :user_id, :integer
    change_column :tradeoffs, :book_id, :integer
  end
end
