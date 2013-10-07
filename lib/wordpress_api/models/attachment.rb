require 'models/init'

module WordpressApi
  class Attachment < BasePost

    default_scope(:default).update(post_type: "attachment")

    before :valid?, :set_defaults

    private

    def set_defaults
      self.post_type = "attachment"
    end

  end
end