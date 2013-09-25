require 'models/init'

module WordpressApi
  class Term

    include DataMapper::Resource

    storage_names[:default] = "wp_terms"

    property :id, Serial, key: true, field: "term_id"
    property :name, String, field: "name"
    property :slug, String, field: "slug"
    property :group, Integer, field: "term_group"

    has n, :taxonomy, "Taxonomy", parent_key: [:id], child_key: [:term_id]

  end
end