class Tradein < ActiveRecord::Base
  def self.find_users(book_id)
    where("book_id = ?",book_id)
  end
end
