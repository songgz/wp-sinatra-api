require 'models/init'

module WordpressApi
  class Post < BasePost

    default_scope(:default).update(post_type: "post")

    before :valid?, :set_defaults

    private

    def set_defaults
      self.post_type = "post"
    end

  end
end