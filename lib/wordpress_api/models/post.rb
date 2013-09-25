require 'models/base_post'

module WordpressApi
  class Post < BasePost

    default_scope(:default).update(post_type: "post")

  end
end