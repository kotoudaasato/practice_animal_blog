class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
      @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(current_user)
  end

  private

  def user_params
      params.require(:user).permit(:name,:profile_image,:introduction)
  end

end
