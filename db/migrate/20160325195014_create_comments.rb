class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index:true
      t.belongs_to :book, index:true
      t.text :title
      t.text :body
      t.integer :like
      t.timestamps null: false
    end
  end
end
