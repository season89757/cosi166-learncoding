class ChangeFieldTypeToString < ActiveRecord::Migration
  def change
    change_column :books, :ISBN, :string
  end
end
