class Forum < ActiveRecord::Base
  has_one :languages
  has_many :posts
end
