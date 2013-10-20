require 'controllers/base_controller'

module WordpressApi
  class CategoriesController < BaseController

    get "/categories" do
      Category.all.to_json
    end

    get "/categories/:id" do
      Category.get!(params[:id]).to_json
    end

    get "/categories/:id/posts" do
      Category.get!(params[:id]).posts.to_json
    end

    get "/categories/:id/pages" do
      Category.get!(params[:id]).pages.to_json
    end

  end
end