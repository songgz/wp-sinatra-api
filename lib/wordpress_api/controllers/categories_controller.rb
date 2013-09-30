require 'controllers/base_controller'

module WordpressApi
  class CategoriesController < BaseController

    configure do
      set :prefix, '/categories'
    end

    get "#{settings.prefix}" do
      Category.all.to_json
    end

    get "#{settings.prefix}/:id" do
      Category.get!(params[:id]).to_json
    end

    get "#{settings.prefix}/:id/posts" do
      Category.get!(params[:id]).posts.to_json
    end

    get "#{settings.prefix}/:id/pages" do
      Category.get!(params[:id]).pages.to_json
    end

  end
end