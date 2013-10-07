require 'models/init'

module WordpressApi
  class Page < BasePost

    default_scope(:default).update(post_type: "page")

    before :valid?, :set_defaults

    private

    def set_defaults
      self.post_type = "page"
    end

  end
end