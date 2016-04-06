class CreatePostreplies < ActiveRecord::Migration
  def change
    create_table :postreplies do |t|
      t.text :content
      t.belongs_to :post, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
      end

    change_table :posts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :forum, index: true

    end
  end
end
