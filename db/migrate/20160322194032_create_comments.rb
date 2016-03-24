class CreateComments < ActiveRecord::Migration
  def change
    drop_table :comments
    create_table :comments do |t|
      t.belongs_to :user, index:true
      t.text :title
      t.text :body
      t.timestamps null: false
    end
  end
end
