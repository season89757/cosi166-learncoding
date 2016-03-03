require_relative '../test_helper'
require 'rails/all'
require 'minitest/autorun'

# 'get' requests work well with the traditional minitest syntax
#   but don't seem to play well with minitest::spec
class ImdbControllerTest < ActionController::TestCase
    def setup
        @one_term = "python"
        @two_terms = "python ruby"
        @existing_user = User.create(username:      "Dickens", 
                                    display_name:   "Charles Dickens",
                                    password:       "great-expectations", 
                                    email:          "anachronism@hotmail.com",
                                    admin:          false)
    end

    ## REGISTER TESTS ##

    test "Register creates a new user" do
        get( :register, username: 'Rushdie', display_name: 'Salman Rushdie', 
            password: 'satanic-verses', confirm: 'satanic-verses',
            email: 'haroun@gmail.com')
        rushdie = User.find_by(username: "Rushdie")
        assert rushdie != nil
        assert_redirected_to(imdb_index_path(:user_id => rushdie.id))
    end

    test "Register rejects if passwords don't match" do
        get( :register, username: 'Rushdie', display_name: 'Salman Rushdie', 
            password: 'satanic-verses', confirm: 'non-matching-password',
            email: 'haroun@gmail.com')
        rushdie = User.find_by(username: "Rushdie")
        assert rushdie == nil
        assert_redirected_to(imdb_register_path(:error => "Passwords do not match"))
    end

    test "Register rejects existing username" do
        get( :register, username: 'Dickens', display_name: 'Salman Rushdie', 
            password: 'satanic-verses', confirm: 'satanic-verses',
            email: 'haroun@gmail.com')
        rushdie = User.find_by(username: "Rushdie")
        assert rushdie == nil
        assert_redirected_to(imdb_register_path(:error => "User or Email already exists"))
    end

    test "Register rejects existing email" do
        get( :register, username: 'Salman', display_name: 'Salman Rushdie', 
            password: 'satanic-verses', confirm: 'satanic-verses',
            email: "anachronism@hotmail.com")
        rushdie = User.find_by(username: "Rushdie")
        assert rushdie == nil
        assert_redirected_to(imdb_register_path(:error => "User or Email already exists"))
    end    

    ## LOGIN TESTS ##

    test "Login logs user in" do
        get :login, username: "Dickens", password: "great-expectations"
        assert_redirected_to(imdb_index_path(:user_id => @existing_user.id)) 
    end    

    test "Login refuses wrong password" do
        get :login, username: "Dickens", password: "wrong_password"
        assert_redirected_to(imdb_login_path(:error => "Wrong credentials")) 
    end

    test "Login refuses unknown username" do
        get :login, username: "Who_Is_this?", password: "great-expectations"
        assert_redirected_to(imdb_login_path(:error => "Wrong credentials")) 
    end

    test "Login refuses empty username" do
        get :login, username: "", password: "great-expectations"
        assert_redirected_to(imdb_login_path(:error => "Wrong credentials")) 
    end    

    test "Login refuses empty password" do
        get :login, username: "Dickens", password: ""
        assert_redirected_to(imdb_login_path(:error => "Wrong credentials")) 
    end    

end