ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

class RSpec::Core::ExampleGroup
  def self.run_all(reporter=nil)
    run(reporter || RSpec::Mocks::Mock.new('reporter').as_null_object)
  end
end
begin
  require 'spork'
rescue LoadError
  module Spork
    def self.prefork
      yield
    end

    def self.each_run
      yield
    end
  end
end
RSpec.configure do |config|
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
end

Spork.prefork do
end

Spork.each_run do
end