require 'ffaker'

FactoryGirl.define do
  
  factory :user, class: WordpressApi::User do
    email { Faker::Internet.email }
    name { Faker::Name.name }
  end

  factory :post, class: WordpressApi::Post do
    association :author, factory: :user
    status WordpressApi::Post::STATUSES.sample
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs(Random.rand(1..5)).join(' ') }
    excerpt { Faker::Lorem.sentences(Random.rand(1..2)).join(' ') }
    comment_status "open"
    comment_count 0
    slug { title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')[0..40].gsub(/(-)$/, '') }
    comment_status WordpressApi::Post::COMMENT_STATUSES.sample
    updated_at { [created_at + Random.rand(500000), Time.now.utc].min }
    created_at { Time.now.utc - Random.rand(1000000) }
  end

end