class Book < ActiveRecord::Base
  has_many :users
  has_many :comments
  has_many :domains
  has_many :languages
end
