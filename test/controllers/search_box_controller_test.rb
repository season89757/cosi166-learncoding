require 'test_helper'

class SearchBoxControllerTest < ActionController::TestCase
    def setup
        @one_term = "python"
        @ruby_term = "ruby"
        @two_terms = "python ruby"
        @two_terms_with_stopwords = "by the python of ruby because for"
        @one_term_all_caps = "PYTHON"
        @two_terms_with_commas = "python, ruby"
        @python_book = Book.create(title:      "Python for Dummies",
                                    ISBN:       42,
                                    author:     "Hanz",
                                    description:"About python, for dummies!")

        @ruby_book = Book.create(title:         "Ruby for Dummies",
                                    ISBN:       29,
                                    author:     "Franz",
                                    description:"About ruby, for dummies!")

        @weak_ruby_result = Book.create(
                    title:       "Programming for Dummies",
                    ISBN:       29,
                    author:     "Ernie",
                    description:"About ruby and other things for dummies!")
    end

    test "searches for one term" do 
        get :search_results, terms: @one_term
        assert_includes(assigns('results'), @python_book)
        #only removes duplicates properly
        assert_equal(1, assigns('results').length)
    end

    test "searches for multiple terms" do
        get :search_results, terms: @two_terms
        assert_includes(assigns('results'), @python_book)
        assert_includes(assigns('results'), @ruby_book)
    end

    test "search removes stopwords" do
        get :search_results, terms: @two_terms_with_stopwords
        assert_equal ["python", "ruby"], assigns('terms')        
    end

    test "search removes commas" do 
        get :search_results, terms: @two_terms_with_commas
        assert_equal ["python", "ruby"], assigns('terms')    
    end

    test "search ignores case" do 
        get :search_results, terms: @one_term_all_caps
        assert_includes(assigns('results'), @python_book)
    end

    test "ranking ranks properly" do 
        get :search_results, terms: @ruby_term
        results = assigns('results')
        assert_equal(results[0], @ruby_book)
    end    

end
