class AddSimilarItemsColumn < ActiveRecord::Migration
  def change
    add_column :books, :similar_items, :string
  end
end
