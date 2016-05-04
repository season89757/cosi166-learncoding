class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :user_id
      t.string :book_id

      t.timestamps null: false
    end
  end
end
