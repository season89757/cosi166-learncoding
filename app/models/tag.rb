class Tag < ActiveRecord::Base
  def self.find_tags(book_id)
    where("book_id = ?",book_id)
  end
end
