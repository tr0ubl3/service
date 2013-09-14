require 'rubygems'
require 'spork'
require "selenium-webdriver"

Spork.prefork do
	ENV["RAILS_ENV"] ||= 'test'
	require 'cucumber/rails'
	# Capybara.default_driver = :selenium
	Capybara.default_selector = :css
	Capybara.default_wait_time = 5
	ActionController::Base.allow_rescue = false
	begin
	  DatabaseCleaner.strategy = :transaction
	rescue NameError
	  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
	end
	Cucumber::Rails::Database.javascript_strategy = :truncation
end

Spork.each_run do
end


