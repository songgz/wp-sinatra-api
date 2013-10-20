require 'models/init'

module WordpressApi
  class UserMeta

    include DataMapper::Resource

    storage_names[:default] = "wp_usermeta"

    property :id, Serial, key: true, field: "umeta_id"
    property :user_id, Integer, field: "user_id", allow_nil: false, min: 1, max: 4294967295
    property :meta_key, String, field: "meta_key", allow_nil: false, length: 255
    property :meta_value, Text, field: "meta_value"

    belongs_to :user, "User", parent_key: [:id], child_key: [:user_id]

    class << self

      # Create shortcuts for UserMeta properties
      [:first_name, :last_name, :nickname, :description].each do |property|
        define_method(property) do
          meta = all(meta_key: property).first
          unless meta.nil?
            meta.meta_value
          end
        end
      end

    end

  end
end