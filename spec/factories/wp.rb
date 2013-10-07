require 'factory_girl'
require 'ffaker'

FactoryGirl.define do
  
  factory :user_meta, class: WordpressApi::UserMeta do; end

  factory :user, class: WordpressApi::User do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    username { Faker::Internet.user_name(name) }
    nicename { username }
    email { Faker::Internet.email(name) }
    password "pass"
    registered_at { Time.now.utc }
    after(:build) do |user|
      first_name, last_name = user.name.split(' ')
      user.user_metas = [
        build(:user_meta, meta_key: 'first_name', meta_value: first_name),
        build(:user_meta, meta_key: 'last_name', meta_value: last_name),
        build(:user_meta, meta_key: 'nickname', meta_value: user.name),
        build(:user_meta, meta_key: 'description', meta_value: Faker::Lorem.sentence),
        build(:user_meta, meta_key: 'wp_user_level', meta_value: 10)
      ]
    end
  end

  factory :base_post_meta, class: WordpressApi::BasePostMeta do; end

  factory :post, class: WordpressApi::Post do
    association :author, factory: :user
    status { WordpressApi::Post::STATUSES.sample }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs(Random.rand(1..5)).join(' ') }
    excerpt { Faker::Lorem.sentences(Random.rand(1..2)).join(' ') }
    slug { title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')[0..40].gsub(/(-)$/, '') }
    comment_status { WordpressApi::Post::COMMENT_STATUSES.sample }
    comment_count 0
    updated_at { [created_at + Random.rand(100000), Time.now.utc].min }
    created_at { Time.now.utc - Random.rand(1000000) }
  end

  factory :term, class: WordpressApi::Term do
    name { Faker::Lorem.words(1).join(' ').capitalize }
    slug { name.downcase }
  end

  factory :tag, class: WordpressApi::Tag do
    association :term, factory: :term
  end

  factory :category, class: WordpressApi::Category do
    association :term, factory: :term
    description { Faker::Lorem.words(Random.rand(3..5)).join(' ') }
  end

end