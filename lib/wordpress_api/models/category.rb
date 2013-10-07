require 'models/init'

module WordpressApi
  class Category < Taxonomy

    default_scope(:default).update(taxonomy_type: "category")

    before :valid?, :set_defaults

    private

    def set_defaults
      self.taxonomy_type = "category"
    end

  end
end