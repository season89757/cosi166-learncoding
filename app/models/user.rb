class User < ActiveRecord::Base
<<<<<<< HEAD
  validates :username, presence: true, uniqueness: true
  #has_secure_password
  has_many :bookss
=======
  validates :name, presence: true, uniqueness: true
  has_secure_password
  has_many :books
>>>>>>> b2523ee8540fdcde3c3bab0b4e17af5a0c5e0cd0
  has_many :posts
  has_many :comments
end
