require 'sinatra/base'
require 'data_mapper'

module WordpressApi
  class DatabaseConfig < Sinatra::Base

    configure :development do
      DataMapper::Logger.new(STDOUT, :debug)
      DataMapper.setup(:default, "mysql://root:root@localhost/wp_dummy")
      DataMapper.finalize
    end

    configure :production do
      DataMapper.setup(:default, "mysql://root:root@localhost/wp_dummy")
      DataMapper.finalize
    end

  end
end