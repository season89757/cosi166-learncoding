class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :book_id
      t.string :sender
      t.string :receiver
      t.text :message

      t.timestamps null: false
    end
  end
end
