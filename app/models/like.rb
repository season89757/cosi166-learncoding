class Like < ActiveRecord::Base
  def self.find_book(user_id)
    where("user_id=?",user_id.to_s).order("created_at DESC").first
  end
end
