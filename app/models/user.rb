class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  #has_secure_password
  has_many :books
  has_many :posts
  has_many :postreplies
  has_many :comments
  has_many :books, :through => :comments
end
