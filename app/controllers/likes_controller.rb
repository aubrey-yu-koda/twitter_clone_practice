class LikesController < ApplicationController
  def create
    @tweeets = tweeet.find(params[:id])
    @tweeet.likes.create
    redirect_to root_url
  end

  def destroy
    @tweeets = tweeet.find(params[:id])
    @tweeet.likes.first.destroy
    redirect_to root_url
  end
end
