require 'sinatra/base'
require 'models/post'

module WordpressApi
  class PostsController < Sinatra::Base

    get '/posts', provides: :json do
      Post.all.to_json
    end

    get '/posts/:id', provides: :json do
      Post.get!(params[:id]).to_json
    end

    get '/configs', provides: :text do
      
    end

  end
end