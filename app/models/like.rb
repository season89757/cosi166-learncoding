class Like < ActiveRecord::Base
  def self.find_book(user_id)
    where("user_id=?",user_id).order("created_at DESC").first
  end
end
