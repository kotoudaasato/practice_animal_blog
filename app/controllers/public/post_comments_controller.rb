class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment.save
    render :index
  end

  def destroy
     PostComment.find_by(id:params[:id]).destroy
     @post = Post.find(params[:post_id])
     render :index
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
