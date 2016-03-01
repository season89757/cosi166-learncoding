# This file is used by Rack-based servers to start the application.
set:database, ENV['DATABASE_URL'] || 'postgres://localhost/IMDBforBooks'
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/IMDBforBooks")
DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://localhost/IMDBforBooks")
require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
