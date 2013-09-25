require 'sinatra/base'

module WordpressApi
  class DefaultConfig < Sinatra::Base

    # Wordpress Timezone
    ENV['TZ'] = 'UTC'

    configure do
      set :root, File.expand_path("#{File.dirname(__FILE__)}/../../../")
    end

    configure :development do
      set :show_exceptions, false
      set :dump_errors, false
    end

  end
end