class Book < ActiveRecord::Base
  has_many :users, :through => :comments
  has_many :comments
  has_many :domains
  has_many :languages
end
