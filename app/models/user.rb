class User < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  #has_secure_password
  has_many :books

  has_many :posts
  has_many :comments
end
