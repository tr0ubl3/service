require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
	require 'cucumber/rails'
	require File.expand_path(File.dirname(__FILE__) + '/../../config/environment' )
	require 'cucumber/formatter/unicode'
	require 'cucumber/rails/world'
	require 'webrat'
	require 'webrat/core/matchers'

	Webrat.configure do |config|
		config.mode = :selenium # was :rack
		config.application_framework = :rack
		config.open_error_files = false
	end

	World(Rack::Test::Methods)
	World(Webrat::Methods)

	ActionController::Base.allow_rescue = false

	Cucumber::Rails::World.use_transactional_fixtures = false
	begin
	  DatabaseCleaner.strategy = :transaction
	rescue NameError
	  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
	end
	Cucumber::Rails::Database.javascript_strategy = :truncation

	if defined?(ActiveRecord::Base)
		begin
			require 'database_cleaner'
			DatabaseCleaner.strategy = :transaction
			rescue LoadError => ignore_if_database_cleaner_not_present
		end
	end

	class ActiveSupport::TestCase
		setup do |session|
			session.host! "localhost:3001"
		end
	end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end