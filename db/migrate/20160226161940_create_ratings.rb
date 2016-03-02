class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :difficulty
      t.integer :quality

      t.timestamps null: false
    end
  end
end
