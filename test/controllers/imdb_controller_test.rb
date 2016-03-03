require 'minitest/autorun'
require_relative '../test_helper'
require 'rails/all'
require_relative '../../app/controllers/application_controller'
require_relative '../../app/controllers/imdb_controller'

describe 'ImdbController' do
  before do
    @imdbcontroller = ImdbController.new
    @imdbcontroller.result
  end

  describe "index" do
    it "in the very beginning , nobody logs in, so user id should be nil" do
      assert_nil(@session,nil)
    end
  end

end
