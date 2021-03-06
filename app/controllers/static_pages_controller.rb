class StaticPagesController < ApplicationController
  def about
  end

  def help
  end

  def home
    if logged_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page],per_page: 20)
    else
      @posts = Post.all.paginate(page: params[:page],per_page: 20)
    end  
  end

  def contact
  end
end
