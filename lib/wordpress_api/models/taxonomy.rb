require 'models/init'

module WordpressApi
  class Taxonomy

    include DataMapper::Resource

    storage_names[:default] = "wp_term_taxonomy"

    default_scope(:default).update(taxonomy_type: "post_tag")

    property :id, Serial, key: true, field: "term_taxonomy_id"
    property :term_id, Integer, field: "term_id", allow_nil: false, min: 1, max: 4294967295
    property :parent_id, Integer, field: "parent", allow_nil: true, min: 1, max: 4294967295
    property :taxonomy_type, String, field: "taxonomy"
    property :description, String, field: "description"
    property :position, Integer, field: "count"

    belongs_to :term, "Term", parent_key: [:id], child_key: [:term_id]
    belongs_to :parent, "Taxonomy", parent_key: [:id], child_key: [:parent_id]
    has n, :base_posts, "BasePost", through: :base_post_taxonomy
    has n, :posts, "Post", through: :base_post_taxonomy
    has n, :pages, "Page", through: :base_post_taxonomy

    # Create shortcuts for Term properties
    [:name, :slug, :group].each do |term_property|
      define_method(term_property) { term.send(term_property) }
    end

    def parent_id=(val)
      val = nil if val == 0
      super
    end

    def as_json(options = {})
      super(
        :only => [:id, :taxonomy_type, :description, :position],
        :methods => [:name, :slug, :group]
      )
    end

  end
end