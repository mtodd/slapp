require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Posts, "#index" do
  
  it "should respond correctly" do
    dispatch_to( Posts, :index ).should respond_successfully
  end
  
end

describe Posts, "#create" do
  
  before(:each) do
    @params = {:body => "It was a good though"}
  end
  
  it "should redirect to #index after successfully creating a Post" do
    lambda {
      dispatch_to(Posts, :create, @params).should redirect_to("/posts/index")
    }.should change(Post, :count)
  end
  
end
