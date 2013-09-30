require 'models/init'

module WordpressApi
  class BasePostTaxonomy

    include DataMapper::Resource

    storage_names[:default] = "wp_term_relationships"

    property :base_post_id, Integer, key: true, field: "object_id", allow_nil: false, min: 1, max: 4294967295
    property :taxonomy_id, Integer, key: true, field: "term_taxonomy_id", allow_nil: false, min: 1, max: 4294967295
    property :position, Integer, field: "term_order"

    belongs_to :base_post, "BasePost", parent_key: [:id], child_key: [:base_post_id]
    belongs_to :post, "Post", parent_key: [:id], child_key: [:base_post_id]
    belongs_to :page, "Page", parent_key: [:id], child_key: [:base_post_id]

    belongs_to :taxonomy, "Taxonomy", parent_key: [:id], child_key: [:taxonomy_id]
    belongs_to :category, "Category", parent_key: [:id], child_key: [:taxonomy_id]
    belongs_to :tag, "Category", parent_key: [:id], child_key: [:taxonomy_id]

  end
end