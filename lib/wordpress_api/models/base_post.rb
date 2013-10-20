require 'models/init'
require 'util/paginates'

module WordpressApi
  class BasePost

    include DataMapper::Resource
    include WordpressApi::Util::Paginates

    storage_names[:default] = "wp_posts"

    POST_TYPES = ["post", "page", "attachment", "revision"]
    STATUSES = ["publish", "pending", "draft", "auto-draft", "private", "inherit"]
    COMMENT_STATUSES = ["open", "closed"]

    # API related properties
    property :id, Serial, key: true, field: "ID"
    property :author_id, Integer, field: "post_author", allow_nil: true, min: 1, max: 4294967295
    property :parent_id, Integer, field: "post_parent", allow_nil: true, min: 0, max: 4294967295
    property :post_type, String, field: "post_type", length: 20
    property :mime_type, String, field: "post_mime_type", length: 100
    property :status, String, field: "post_status", length: 20
    property :title, Text, field: "post_title"
    property :content, Text, field: "post_content"
    property :excerpt, Text, field: "post_excerpt"
    property :slug, String, field: "post_name", length: 200
    property :url, Text, field: "guid"
    property :comment_status, String, field: "comment_status", length: 20
    property :comment_count, Integer, field: "comment_count", allow_nil: true, min: 0
    property :updated_at, DateTime, field: "post_modified_gmt"
    property :created_at, DateTime, field: "post_date_gmt"

    # Not API related properties (but used by Wordpress)
    property :local_updated_at, DateTime, field: "post_modified"
    property :local_created_at, DateTime, field: "post_date"
    property :ping_status, String, field: "ping_status", length: 20
    property :to_ping_content, Text, field: "to_ping"
    property :pinged_content, Text, field: "pinged"
    property :password, String, field: "post_password", length: 20
    property :filtered_content, Text, field: "post_content_filtered"
    property :position, Integer, field: "menu_order", min: 0

    belongs_to :author, "User", parent_key: [:id], child_key: [:author_id]
    belongs_to :parent, "BasePost", parent_key: [:id], child_key: [:parent_id]
    has n, :children, "BasePost", parent_key: [:id], child_key: [:parent_id]
    has n, :taxonomies, "Taxonomy", through: :base_post_taxonomy
    has n, :categories, "Category", through: :base_post_taxonomy
    has n, :tags, "Category", through: :base_post_taxonomy
    has n, :base_post_metas, "BasePostMeta", parent_key: [:id], child_key: [:post_id]

    validates_within :post_type, set: POST_TYPES
    validates_within :status, set: STATUSES
    validates_within :comment_status, set: COMMENT_STATUSES

    # Create shortcuts for BasePostMeta properties
    [:thumbnail].each do |bpm_property|
      define_method(bpm_property) { base_post_metas.send(bpm_property) }
    end

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

    class << self

      def published
        all(status: 'publish')
      end

    end
    
  end
end