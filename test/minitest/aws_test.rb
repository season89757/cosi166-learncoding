require 'minitest/autorun'
require 'amazon/ecs'
require_relative '../test_helper'

describe "aws_api" do
  before do
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = 'AKIAIGLTXMSS4JLNHH6A'
      options[:AWS_secret_key] = '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'
      options[:associate_tag] = 'i0a70-20'
    end

    @res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium', :sort => 'salesrank', :search_index => 'Books', :title => 'ruby', :country => 'us'})
  end

  it "the get title method works." do
    @res.items[0].get('ItemAttributes/Title').must_equal "The Story Of Ruby Bridges: Special Anniversary Edition"
  end

  it "the get author method works." do
    @res.items[0].get('ItemAttributes/Author').must_equal "Robert Coles"
  end

  it "the get ItemDimensions/Height method works." do
    @res.items[0].get('ItemAttributes/ItemDimensions/Height').must_equal "1050"
  end

end
