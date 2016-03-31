class AddRatingInfo < ActiveRecord::Migration
  def change
    add_column :books, :average_rating, :string
    add_column :books, :ratings_count, :string
  end
end
