require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Post do

  it "should NOT be valid when new" do
    post = Post.new
    post.should_not be_valid
  end
  
  it "should require at least two body characters to be valid" do
    post = Post.new
    post.should_not be_valid
    post.errors.on(:body).should include("is too short (minimum is 2 characters)")
  end

end
