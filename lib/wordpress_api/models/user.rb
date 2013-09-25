require 'models/init'

module WordpressApi
  class User

    include DataMapper::Resource

    storage_names[:default] = "wp_users"

    property :id, Serial, key: true, field: "ID"
    property :email, String, field: "user_email"
    property :name, String, field: "display_name"

    has n, :posts, "Post", parent_key: [:id], child_key: [:author_id]
    has n, :pages, "Page", parent_key: [:id], child_key: [:author_id]
    
  end
end