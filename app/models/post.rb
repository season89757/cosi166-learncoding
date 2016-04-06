class Post < ActiveRecord::Base
  has_many :postreplies
end
