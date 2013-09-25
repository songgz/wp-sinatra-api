require 'models/init'

module WordpressApi
  class BasePost

    include DataMapper::Resource

    storage_names[:default] = "wp_posts"

    property :id, Serial, key: true, field: "ID"
    property :author_id, Integer, field: "post_author"
    property :post_type, String, field: "post_type"
    property :status, String, field: "post_status"
    property :title, Text, field: "post_title"
    property :content, Text, field: "post_content"
    property :excerpt, Text, field: "post_excerpt"
    property :commentable, String, field: "comment_status"
    property :comment_count, Integer, field: "comment_count"
    property :slug, String, field: "post_name"
    property :update_at, DateTime, field: "post_modified"
    property :created_at, DateTime, field: "post_date"

    belongs_to :author, "User", parent_key: [:id], child_key: [:author_id]
    has n, :taxonomies, "Taxonomy", through: :base_post_taxonomy
    has n, :categories, "Category", through: :base_post_taxonomy
    has n, :tags, "Category", through: :base_post_taxonomy
    
  end
end