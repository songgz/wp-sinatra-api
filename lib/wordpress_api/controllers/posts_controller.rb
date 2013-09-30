require 'controllers/base_controller'

module WordpressApi
  class PostsController < BaseController

    configure do
      set :prefix, '/posts'
    end

    get "#{settings.prefix}" do
      paginate(Post.all(:order => [ :created_at.desc ]), params).to_json
    end

    get "#{settings.prefix}/:id" do
      Post.get!(params[:id]).to_json
    end

  end
end