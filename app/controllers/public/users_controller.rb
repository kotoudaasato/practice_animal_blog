class Public::UsersController < ApplicationController

  def show
      @user = User.find(params[:id])
      #byebug
  end

  private

  def user_params
      params.require(:user).permit(:name,:profile_image,:introduction)
  end

end
