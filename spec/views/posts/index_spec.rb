require File.join(File.dirname(__FILE__), "..", "..", "spec_helper.rb")

describe "posts/index" do
  
  before(:each) do
    @controller = Posts.new(fake_request)
    @posts = [Post.create(:body => "Merb", :created_at => Time.now), Post.create(:body => "Rocks!", :created_at => Time.now)]
    @controller.instance_variable_set(:@posts, @posts)
    @body = @controller.render(:index)
  end
  
  it "should have a containing div for the posts" do
    @body.should have_selector("div#posts.container")
  end
  
  it "should have a div for each individual post" do
    @posts.each do |post| 
      @body.should have_selector("div#posts.container div#post-#{post.id}.post")
    end
  end
  
  it "should have the contents of each post inside a div with an id and class" do
    @posts.each do |post|
      @body.should match_tag(:div, :id => "post-#{post.id}", :class => "post", :content => post.body)
    end
  end
  
  after( :each ) do
    Post.destroy_all
  end
  
end
