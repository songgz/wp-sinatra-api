require 'data_mapper'

module WordpressApi
  class Taxonomy

    include DataMapper::Ressource

    storage_names[:default] = "wp_term_taxonomy"

    property :id, Serial, key: true, field: "term_taxonomy_id"
    property :term_id, Integer, field: "term_id"
    property :parent_id, Integer, field: "parent"
    property :taxonomy_type, String, field: "taxonomy"
    property :description, String, field: "description"
    property :position, Integer, field: "count"

    def parent_id=(val)
      val = nil if val == 0
      super
    end
    
  end
end