require 'test_helper'

class SearchBoxControllerTest < ActionController::TestCase
    def setup
        @one_term = "python"
        @two_terms = "python ruby"
        @python_book = Book.create(title:      "Python for Dummies",
                                    ISBN:       42,
                                    author:     "Hanz",
                                    description:"About python, for dummies!")

        @ruby_book = Book.create(title:         "Ruby for Dummies",
                                    ISBN:       29,
                                    author:     "Franz",
                                    description:"About ruby, for dummies!")
    end

    test "searches for one term" do 
        get :search_results, terms: @one_term
        assert_includes(assigns('results'), @python_book)
    end

    test "searches for multiple terms" do
        get :search_results, terms: @two_terms
        assert_includes(assigns('results'), @python_book)
        assert_includes(assigns('results'), @ruby_book)
    end

end
