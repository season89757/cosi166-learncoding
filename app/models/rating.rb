class Rating < ActiveRecord::Base
  has_many :books
end
