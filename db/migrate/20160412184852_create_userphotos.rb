class CreateUserphotos < ActiveRecord::Migration
  def change
    create_table :userphotos do |t|
      t.string :username
      t.string :attachment

      t.timestamps null: false
    end
  end
end
