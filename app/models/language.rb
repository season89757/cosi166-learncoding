class Language < ActiveRecord::Base
  #has_one :languages
  has_many :books
end
