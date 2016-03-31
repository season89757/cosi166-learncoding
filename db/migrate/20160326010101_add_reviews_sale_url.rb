class AddReviewsSaleUrl < ActiveRecord::Migration
  def change
    add_column :books, :reviews, :string
    add_column :books, :sale_url, :string
  end
end
