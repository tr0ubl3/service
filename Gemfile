source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
	gem 'sqlite3'
	gem 'rspec'
	gem 'rspec-rails'
	gem "selenium-client" , ">= 1.2.18"

	## guard gems begin 
	gem 'guard', :github => 'guard/guard'
	gem 'guard-spork', :github => 'guard/guard-spork'
	gem 'guard-rspec', :github => 'guard/guard-rspec'
	# gem 'guard-cucumber', :github => 'guard/guard-cucumber'
	## end
	gem 'commands'
	gem 'factory_girl_rails', :require => false
end

group :production do
	gem 'pg'
end

group :test do
	gem 'spork', :github => 'sporkrb/spork'
	gem 'capybara', :github => 'jnicklas/capybara'
	gem 'cucumber', '1.2.5'
	gem 'cucumber-rails', :require => false 
	gem 'rb-fchange', '0.0.5'
	gem 'rb-notifu', '0.0.4'
	gem 'win32console'
	gem 'wdm'
	gem 'growl'
	gem 'ruby_gntp'
	gem 'win32-process'
	gem 'database_cleaner'
	gem 'childprocess', '0.3.6'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'js-routes'
gem 'bootstrap-datepicker-rails'
gem 'active_link_to'
gem 'state_machine'
gem 'state_machine-audit_trail'
gem 'thin'
gem 'eventmachine'
gem 'font-awesome-rails'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'