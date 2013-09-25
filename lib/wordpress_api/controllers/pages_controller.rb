require 'sinatra/base'
require 'models/page'

module WordpressApi
  class PagesController < Sinatra::Base

    get '/pages', provides: :json do
      Page.all.to_json
    end

    get '/pages/:id', provides: :json do
      Page.get!(params[:id]).to_json
    end

  end
end