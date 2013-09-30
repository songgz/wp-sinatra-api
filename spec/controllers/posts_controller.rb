require File.expand_path '../spec_helper.rb', File.dirname(__FILE__)

describe "PostsController" do
  before do
    DatabaseCleaner.clean
    @posts = 10.times.map { post = build(:post); post.save; post }
  end

  context "GET /posts" do
    before do
      get '/posts'
    end

    it "should respond with code 200 and Json" do
      last_response.status.should == 200
      last_response.content_type.should == "application/json;charset=utf-8"
    end

    it "should " do
      
    end
  end

  context "GET /posts/:id" do

  end
end