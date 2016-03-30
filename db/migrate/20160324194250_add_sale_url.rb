class AddSaleUrl < ActiveRecord::Migration
  def changesale_url
    add_column :books, :sale_url, :string
  end
end
