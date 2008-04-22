require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Posts, "index action" do
  before(:each) do
    dispatch_to(Posts, :index)
  end
end