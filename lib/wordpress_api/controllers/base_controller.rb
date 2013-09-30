require 'sinatra/base'
require 'data_mapper'
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

    helpers do
      def paginate(query, params = {})
        limit = params.key?(:limit) ? params[:limit] : Configs.pagination.limit
        if limit
          if params.key?(:after)
            query.all(:created_at.gt => params[:after], :limit => limit)
          elsif params.key?(:before)
            query.all(:created_at.lt => params[:before], :limit => limit)
          elsif params.key?(:page)
            query.all(:offset => (params[:page] - 1) * limit, :limit => limit)
          else
            query.all(:limit => limit)
          end
        else
          query
        end
      end
    end

  end
end