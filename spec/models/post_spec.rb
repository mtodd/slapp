require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Post do

  it "should be valid when new" do
    post = Post.new
    post.should be_valid
  end

end