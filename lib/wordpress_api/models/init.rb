require 'data_mapper'
require 'models/user'
require 'models/base_post'
require 'models/post'
require 'models/page'
require 'models/term'
require 'models/taxonomy'
require 'models/category'
require 'models/tag'
require 'models/base_post_taxonomy'

DataMapper.setup(:default, 
  adapter: WordpressApi::Configs.db.adapter,
  host: WordpressApi::Configs.db.host,
  username: WordpressApi::Configs.db.username,
  password: WordpressApi::Configs.db.password,
  database: WordpressApi::Configs.db.database
)
DataMapper.finalize