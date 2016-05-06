class Change < ActiveRecord::Migration
  def change
    change_column :messages, :sender, :integer
    change_column :messages, :receiver, :integer
  end
end
