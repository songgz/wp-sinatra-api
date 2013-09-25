require 'sinatra/base'

module WordpressApi
  class DefaultController < Sinatra::Base

    get '/', provides: :text do
      "default controller"
    end

  end
end