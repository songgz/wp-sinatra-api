require 'models/init'

module WordpressApi
  class Tag < Taxonomy

    default_scope(:default).update(taxonomy_type: "post_tag")

    before :valid?, :set_defaults

    private

    def set_defaults
      self.taxonomy_type = "post_tag"
    end

  end
end