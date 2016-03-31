class AddSaleRankAndPreviewUrl < ActiveRecord::Migration
  def change
    add_column :books, :sales_rank, :string
    add_column :books, :preview_url, :string
  end
end
