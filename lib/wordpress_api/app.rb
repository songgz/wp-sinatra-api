$LOAD_PATH.unshift("#{File.dirname(__FILE__)}")

require 'sinatra/base'
require 'version'
require 'controllers/posts_controller'
require 'controllers/pages_controller'
require 'controllers/categories_controller'

module WordpressApi
  class App < Sinatra::Base

    # Controllers
    use WordpressApi::PostsController
    use WordpressApi::PagesController
    use WordpressApi::CategoriesController

  end
end