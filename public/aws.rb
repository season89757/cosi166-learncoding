require 'amazon/ecs'

class Awsapi
  attr_accessor :res, :num

  def initialize(num)
    @num = num
    search_api(@num)
  end

  def search_api(num)
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = 'AKIAIGLTXMSS4JLNHH6A'
      options[:AWS_secret_key] = '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'
      options[:associate_tag] = 'i0a70-20'
    end
    # options will be merged with the default options
    @res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium', :sort => 'salesrank', :search_index => 'Books', :title => 'ruby', :country => 'us'})
    # res.is_valid_request?
    # res.has_error?
    # res.error                                 # error message
    # res.total_pages
    # res.total_results
    # res.item_page                             # current page no if :item_page option is provided

    # find elements matching 'Item' in response object
    # res.items.each do |item|
    #   # retrieve string value using XML path
    #   item.get('ASIN')
    #   item.get('ItemAttributes/Title')
    #
    #   # return Amazon::Element instance
    #   item_attributes = item.get_element('ItemAttributes')
    #   item_attributes.get('Title')
    #   #puts item_attributes.get('Content')
    #   item_attributes.get_unescaped('Title') # unescape HTML entities
    #   item_attributes.get_array('Author')    # ['Author 1', 'Author 2', ...]
    #   item_attributes.get('Author')          # 'Author 1'
    #
    #   # return a hash object with the element names as the keys
    #   item.get_hash('SmallImage') # {:url => ..., :width => ..., :height => ...}
    #
    #   # return the first matching path
    #   item_height = item.get_element('ItemDimensions/Height')
    #   item_height.attributes['Units']        # 'hundredths-inches'
    #
    #   # there are two ways to find elements:
    #   # 1) return an array of Amazon::Element
    #   reviews = item.get_elements('EditorialReview')
    #
    #   # 2) return Nokogiri::XML::NodeSet object or nil if not found
    #   reviews = item/'EditorialReview'
    #   reviews.each do |review|
    #     el = Amazon::Element.new(review)
    #     el.get('Content')
    #   end
    # end
  end
end
