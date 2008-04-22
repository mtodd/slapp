require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Posts, "#index" do
  
  it "should respond correctly" do
    dispatch_to( Posts, :index ).should respond_successfully
  end
  
end