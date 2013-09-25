$LOAD_PATH.unshift("#{File.dirname(__FILE__)}")

require 'sinatra/base'
require 'configs/default_config'
require 'configs/database_config'
require 'controllers/default_controller'
require 'controllers/posts_controller'
require 'controllers/pages_controller'
require 'controllers/error_controller'
require 'version'

module WordpressApi
  class App < Sinatra::Base

    # Configs
    use WordpressApi::DefaultConfig
    use WordpressApi::DatabaseConfig

    # Controllers
    use WordpressApi::DefaultController
    use WordpressApi::PostsController
    use WordpressApi::PagesController
    use WordpressApi::ErrorController

  end
end