class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).per(12).reverse_order
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).per(12)
  end

  def search_favorite
    @posts = Post.last_week
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end
