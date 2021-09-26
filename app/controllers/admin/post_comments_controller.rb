class Admin::PostCommentsController < ApplicationController
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
