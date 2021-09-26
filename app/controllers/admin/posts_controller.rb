class Admin::PostsController < ApplicationController
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
end
