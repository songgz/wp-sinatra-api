require 'controllers/base_controller'

module WordpressApi
  class PostsController < BaseController

    get "/posts" do
      Post.published.all(:order => [ :created_at.desc ]).paginate(params).to_json
    end

    get "/posts/:id" do
      Post.published.get!(params[:id]).to_json
    end

  end
end