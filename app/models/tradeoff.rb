class Tradeoff < ActiveRecord::Base
  # validates :user_id, presence: true
  # validates :book_id, presence: true
  def self.find_users(book_id)
    where("book_id = ?",book_id)
  end

end
