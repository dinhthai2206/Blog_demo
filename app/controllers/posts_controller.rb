class PostsController < ApplicationController
  before_action :get_post, only: [:destroy, :show, :edit]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end


  def destroy
    byebug
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page], per_page: 20)
    @comment = @post.comments.build(user_id: current_user.id) if logged_in?
  end

  def new
    @post = Post.new
  end

  def index
    @posts = Post.order("created_at DESC").limit(10)
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'  
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :picture)
    end

    def get_post
      @post = Post.find_by(id: params[:id])
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url unless @post.user == current_user
    end
end