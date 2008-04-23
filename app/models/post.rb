class Post < ActiveRecord::Base
  
  validates_length_of :body, :minimum => 2
  
end
