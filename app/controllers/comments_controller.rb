class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :current_user, only: [:destroy, :edit, :update]
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body).merge(user_id: current_user.id))
      flash[:success] = "Comment created"
      redirect_to post_path(@post)
  end
 
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to post_path(@post)
  end
  
  def edit
    
  end

  def update
    @post = Post.find(params[:id])
    @comment = @post.comments.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'  
    end
  end
end
