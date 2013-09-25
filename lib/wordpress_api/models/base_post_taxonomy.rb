require 'data_mapper'

module WordpressApi
  class BasePostTaxonomy

    include DataMapper::Ressource

    storage_names[:default] = "wp_term_relationships"

    property :base_post_id, Integer, key: true, field: "object_id"
    property :taxonomy_id, Integer, key: true, field: "term_taxonomy_id"
    property :position, Integer, field: "term_order"



  end
end