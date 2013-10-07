require 'factory_girl'
require 'ffaker'

FactoryGirl.define do
  
  factory :user, class: WordpressApi::User do
    email { Faker::Internet.email }
    name { Faker::Name.name }
  end

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