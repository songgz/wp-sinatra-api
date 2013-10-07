require 'rake'
require 'database_cleaner'
require './lib/wordpress_api/app'
require './spec/factories/wp'

task :environment do
  raise "You need to specify an environment with RACK_ENV!" unless ENV.key?('RACK_ENV')
  @env = ENV['RACK_ENV']
end

namespace :db do
  desc "Update the database schema without purging data"
  task :update => :environment do
    DataMapper.auto_upgrade!
  end

  desc "Migrate the database schema - purges data"
  task :migrate => :environment do
    DataMapper.auto_migrate!
  end

  desc "Purges all data from the database"
  task :clean => :environment do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  desc "Populates the database with random data"
  task :populate => :environment do
    users = 5.times.map { user = FactoryGirl.build(:user); user.save; user }
    tags = 20.times.map { tag = FactoryGirl.build(:tag); tag.save; tag }
    categories = 10.times.map { category = FactoryGirl.build(:category); category.save; category }
    posts = 50.times.map do 
      post = FactoryGirl.build(:post, author: users.sample)
      post.tags = tags.sample(rand(tags.count))
      post.categories = categories.sample(rand(1..3))
      puts "Errors on post: #{post.errors.to_a.to_s}" unless post.save
      post
    end
  end

  desc "Cleans the database, then populates it with random data"
  task :clean_and_populate => [:clean, :populate]
end