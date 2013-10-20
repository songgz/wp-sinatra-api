require 'sinatra/base'
require 'data_mapper'
require 'json'
require 'configs'
require 'models/init'

module WordpressApi
  class BaseController < Sinatra::Base

    configure do
      ENV['TZ'] = "UTC"
      set :root, File.expand_path("#{File.dirname(__FILE__)}/../../../")
    end

    configure :development do
      DataMapper::Logger.new(STDOUT, :debug)
      set :show_exceptions, false
      # set :dump_errors, false
    end

    before do
      content_type :json
    end

    error DataMapper::ObjectNotFoundError do
      { code: 410, status: :error, message: "object_not_found" }.to_json
    end

    not_found do
      { code: 404, status: :error, message: "not_found" }.to_json
    end

  end
end