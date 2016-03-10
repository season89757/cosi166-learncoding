class AddImageUrlToBook < ActiveRecord::Migration
  def change
    add_column :books, :image_url, :string
    add_column :books, :publisher, :string
    add_column :books, :total_pages, :string
    add_column :books, :written_language, :string
    add_column :books, :asin, :string
    add_column :books, :price, :string
  end
end
