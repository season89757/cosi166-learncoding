class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :ISBN
      t.string :author
      t.date :publish_date
      t.text :description

      t.timestamps null: false
    end
  end
end
