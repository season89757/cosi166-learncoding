class Comment < ActiveRecord::Base
  #validates :title, presence: true
  #validates :body, presence: true
  belongs_to :user
  belongs_to :book
end
