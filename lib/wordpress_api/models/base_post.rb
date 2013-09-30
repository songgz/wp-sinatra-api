require 'models/init'

module WordpressApi
  class BasePost

    include DataMapper::Resource

    storage_names[:default] = "wp_posts"

    POST_TYPES = ["post", "page", "attachment", "revision"]
    STATUSES = ["publish", "pending", "draft", "auto-draft", "private", "inherit"]
    COMMENT_STATUSES = ["open", "closed"]

    property :id, Serial, key: true, field: "ID"
    property :author_id, Integer, field: "post_author", allow_nil: true, min: 1, max: 4294967295
    property :post_type, String, field: "post_type"
    property :mime_type, String, field: "post_mime_type"
    property :status, String, field: "post_status"
    property :title, Text, field: "post_title"
    property :content, Text, field: "post_content"
    property :excerpt, Text, field: "post_excerpt"
    property :slug, String, field: "post_name"
    property :url, Text, field: "guid"
    property :comment_status, String, field: "comment_status"
    property :comment_count, Integer, field: "comment_count", allow_nil: true, min: 0
    property :updated_at, DateTime, field: "post_modified_gmt"
    property :created_at, DateTime, field: "post_date_gmt"

    belongs_to :author, "User", parent_key: [:id], child_key: [:author_id]
    has n, :taxonomies, "Taxonomy", through: :base_post_taxonomy
    has n, :categories, "Category", through: :base_post_taxonomy
    has n, :tags, "Category", through: :base_post_taxonomy

    validates_within :post_type, set: POST_TYPES
    validates_within :status, set: STATUSES
    validates_within :comment_status, set: COMMENT_STATUSES

    def as_json(options = {})
      super(
        :only => [:id, :post_type, :status, :title, :content, :excerpt, :commentable, :comment_count, :slug, :updated_at, :created_at],
        :methods => [:author],
        :include => {
          :author => {
            :only => [:name]
          }
        }
      )
    end
    
  end
end