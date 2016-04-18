class ChangeUsernameToUserid < ActiveRecord::Migration
  def change
    remove_column :userphotos, :username, :string
    add_column :userphotos, :userid, :integer
  end
end
