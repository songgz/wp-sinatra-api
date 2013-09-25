require 'sinatra/base'
require 'data_mapper'

module WordpressApi
  class ErrorController < Sinatra::Base

    error ::DataMapper::ObjectNotFoundError do
      { code: 410, status: :error, message: "object_not_found" }.to_json
    end

    not_found do
      { code: 404, status: :error, message: "not_found" }.to_json
    end

  end
end