require 'data_mapper'

module WordpressApi
  class Term
    
    include DataMapper::Ressource

    storage_names[:default] = "wp_terms"

    property :id, Serial, key: true, field: "term_id"
    property :name, String, field: "name"
    property :slug, String, field: "slug"
    property :group, Integer, field: "term_group"

  end
end