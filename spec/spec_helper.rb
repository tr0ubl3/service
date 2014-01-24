require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factory_girl_rails'
  require 'email_spec'
  require 'capybara/rspec'
  require 'rack_session_access/capybara'
  ActiveSupport::Dependencies.clear
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  # Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  # Dir["#{Rails.root}/app/models/**/*.rb"].each {|f| load f}
  RSpec.configure do |config|
    # require "rails/application"
    Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
    require File.dirname(__FILE__) + "/../config/environment.rb"
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include FactoryGirl::Syntax::Methods
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus
    config.run_all_when_everything_filtered = true
    config.before(:each) do
      @real_world = RSpec.world
      RSpec.instance_variable_set(:@world, RSpec::Core::World.new)
    end
    config.order = "random"
    config.fuubar_progress_bar_options = { :format => 'My Fuubar! <%B> %p%% %a' }
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    config.include Capybara::DSL
  end
end

Spork.each_run do
end