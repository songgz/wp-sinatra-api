require 'models/init'

module WordpressApi
  class BasePostMeta

    include DataMapper::Resource

    storage_names[:default] = "wp_postmeta"

    property :id, Serial, key: true, field: "meta_id"
    property :post_id, Integer, field: "post_id", allow_nil: false, min: 1, max: 4294967295
    property :meta_key, String, field: "meta_key", allow_nil: false, length: 255
    property :meta_value, Text, field: "meta_value"

    belongs_to :base_post, "BasePost", parent_key: [:id], child_key: [:post_id]

    class << self

      def thumbnail
        meta = all(meta_key: '_thumbnail_id').first
        unless meta.nil?
          Attachment.get(meta.meta_value)
        end
      end

    end

  end
end