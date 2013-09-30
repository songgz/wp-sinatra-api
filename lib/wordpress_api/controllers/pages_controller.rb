require 'controllers/base_controller'

module WordpressApi
  class PagesController < BaseController

    configure do
      set :prefix, '/pages'
    end

    get "#{settings.prefix}" do
      Page.all.to_json
    end

    get "#{settings.prefix}/:id" do
      Page.get!(params[:id]).to_json
    end

  end
end