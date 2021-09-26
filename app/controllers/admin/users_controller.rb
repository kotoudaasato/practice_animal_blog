class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20).reverse_order
  end

  def show
      @user = User.find(params[:id])
      @posts = @user.posts
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
      params.require(:user).permit(:name,:profile_image,:introduction)
  end
end
