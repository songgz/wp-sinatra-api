require 'settingslogic'

module WordpressApi
  class Configs < Settingslogic
    source File.expand_path("#{File.dirname(__FILE__)}/../../config/application.yml")
    namespace ENV['RACK_ENV'] || "development"
  end
end