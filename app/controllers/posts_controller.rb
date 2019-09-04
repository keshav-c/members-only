class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = "an error occured!"
      render 'new'
    end
  end

  def index
    @posts = Post.includes(:user).all
  end

  private 
    def post_params
      params.require(:post).permit(:content)
    end
end
