require 'factory_girl'
require 'ffaker'

FactoryGirl.define do
  
  factory :user_meta, class: WordpressApi::UserMeta do; end

  factory :user, class: WordpressApi::User do
    username { Faker::Internet.user_name(display_name) }
    email { Faker::Internet.email(display_name) }
    status 0
    url_name ''
    display_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    password '$P$Bxv017uNZO5kruzeRMtVVNNe3zyqOs1'
    url ''
    registered_at { Time.now.utc }
    activation_key ''
    after(:build) do |user|
      first_name, last_name = user.display_name.split(' ')
      user.user_metas = [
        build(:user_meta, meta_key: 'first_name', meta_value: first_name),
        build(:user_meta, meta_key: 'last_name', meta_value: last_name),
        build(:user_meta, meta_key: 'nickname', meta_value: user.display_name),
        build(:user_meta, meta_key: 'description', meta_value: Faker::Lorem.sentence),
        build(:user_meta, meta_key: 'wp_user_level', meta_value: 10)
      ]
    end
  end

  factory :base_post_meta, class: WordpressApi::BasePostMeta do; end

  factory :post, class: WordpressApi::Post do
    association :author, factory: :user
    # parent_id 0
    mime_type ''
    status { WordpressApi::Post::STATUSES.sample }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs(Random.rand(1..5)).join(' ') }
    excerpt { Faker::Lorem.sentences(Random.rand(1..2)).join(' ') }
    slug { title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')[0..40].gsub(/(-)$/, '') }
    url ''
    comment_status { WordpressApi::Post::COMMENT_STATUSES.sample }
    comment_count 0
    updated_at { [created_at + Random.rand(100000), Time.now.utc].min }
    created_at { Time.now.utc - Random.rand(1000000) }
    local_updated_at { updated_at.localtime }
    local_created_at { created_at.localtime }
    ping_status ''
    to_ping_content ''
    pinged_content ''
    password ''
    filtered_content ''
    position 0
  end

  factory :term, class: WordpressApi::Term do
    sequence(:name) { |n| "#{Faker::Lorem.words(1).join(' ').capitalize}#{n}" }
    slug { name.downcase }
    group 0
  end

  factory :tag, class: WordpressApi::Tag do
    association :term, factory: :term
    # parent_id 0
    description ''
    position 0
  end

  factory :category, class: WordpressApi::Category do
    association :term, factory: :term
    # parent_id 0
    description { Faker::Lorem.words(Random.rand(3..5)).join(' ') }
    position 0
  end

end