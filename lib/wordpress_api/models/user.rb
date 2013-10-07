require 'models/init'

module WordpressApi
  class User

    include DataMapper::Resource

    storage_names[:default] = "wp_users"

    property :id, Serial, key: true, field: "ID"
    property :username, String, field: "user_login", allow_nil: false, length: 60
    property :password, String, field: "user_pass", allow_nil: false, length: 64
    property :nicename, String, field: "user_nicename", length: 50
    property :email, String, field: "user_email", allow_nil: false, length: 100
    property :url, String, field: "user_url", length: 100
    property :registered_at, DateTime, field: "user_registered"
    property :activation_key, String, field: "user_activation_key", length: 60
    property :status, Integer, field: "user_status", default: 0
    property :name, String, field: "display_name", allow_nil: false, length: 250

    has n, :user_metas, "UserMeta", parent_key: [:id], child_key: [:user_id]
    has n, :base_posts, "BasePost", parent_key: [:id], child_key: [:author_id]
    has n, :posts, "Post", parent_key: [:id], child_key: [:author_id]
    has n, :pages, "Page", parent_key: [:id], child_key: [:author_id]

    # Create shortcuts for UserMeta properties
    [:first_name, :last_name, :nickname, :description].each do |um_property|
      define_method(um_property) { user_metas.send(um_property) }
    end

    def as_json(options = {})
      super(
        :only => [:id, :name]
      )
    end
    
  end
end