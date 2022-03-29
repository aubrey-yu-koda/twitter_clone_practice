class ProfileUsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweeets = @user.tweeets.order("created_at DESC")
  end
end
