class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.text :title
      t.integer :agree

      t.timestamps null: false
    end
  end
end
