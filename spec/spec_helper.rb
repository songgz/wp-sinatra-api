ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'database_cleaner'
require 'factory_girl'
require File.expand_path '../lib/wordpress_api/app.rb', File.dirname(__FILE__)

module RSpecMixin
  include Rack::Test::Methods
  def app() WordpressApi::App end
end

RSpec.configure do |config| 
  config.include RSpecMixin
  config.include FactoryGirl::Syntax::Methods

  config.mock_with :rspec
  config.order = "random"

  config.before(:suite) do
    # DataMapper.auto_migrate!
    DatabaseCleaner.strategy = :truncation
  end
end

FactoryGirl.find_definitions