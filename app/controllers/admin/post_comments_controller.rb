class Admin::PostCommentsController < ApplicationController

  before_action :authenticate_admin!

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
