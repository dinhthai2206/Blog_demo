class CommentsController < ApplicationController
  def index
    @comment = Comment.all
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@comment.post), notice: "Comment created!" }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated"
      redirect_to post_path(@comment.post)
    else
      render 'edit'
    end
  end

  def show
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
    

end