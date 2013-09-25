require 'models/init'

module WordpressApi
  class Taxonomy

    include DataMapper::Resource

    storage_names[:default] = "wp_term_taxonomy"

    default_scope(:default).update(taxonomy_type: "post_tag")

    property :id, Serial, key: true, field: "term_taxonomy_id"
    property :term_id, Integer, field: "term_id"
    property :parent_id, Integer, field: "parent"
    property :taxonomy_type, String, field: "taxonomy"
    property :description, String, field: "description"
    property :position, Integer, field: "count"

    belongs_to :term, "Term", parent_key: [:id], child_key: [:term_id]
    has n, :base_posts, "BasePost", through: :base_post_taxonomy
    has n, :posts, "Post", through: :base_post_taxonomy
    has n, :pages, "Page", through: :base_post_taxonomy

    # Create shortcuts for Term properties
    [:name, :slug, :group].each do |term_property|
      define_method term_property do
        term.send(term_property)
      end
    end

    def parent_id=(val)
      val = nil if val == 0
      super
    end

  end
end