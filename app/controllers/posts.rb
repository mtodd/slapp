class Posts < Application
  
  def index
    @posts = Post.find(:all, :order => "created_at DESC")
    render
  end
  
  def create
    Post.create!(:body => params[:body])
    redirect url(:action => "index")
  end
  
end
