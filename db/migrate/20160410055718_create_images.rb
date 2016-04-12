class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :base64

      t.timestamps null: false
    end
  end
end
