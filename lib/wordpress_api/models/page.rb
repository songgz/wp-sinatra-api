require 'models/base_post'

module WordpressApi
  class Page < BasePost

    default_scope(:default).update(post_type: "page")

  end
end