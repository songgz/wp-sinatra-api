require 'controllers/base_controller'

module WordpressApi
  class PagesController < BaseController

    get "/pages" do
      Page.all.to_json
    end

    get "/pages/:id" do
      Page.get!(params[:id]).to_json
    end

  end
end