class TweeetsController < ApplicationController
  before_action :set_tweeet, only: [:edit, :update, :destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /tweeets or /tweeets.json
  def index
    @tweeets = Tweeet.all.order("created_at DESC")
    @tweeet = Tweeet.new
    
    if user_signed_in?
      @users = User.all.order("RANDOM()").where.not(:id=>current_user.id)
      @user = current_user
    else
      @users = User.all.order("RANDOM()")
    end 
  end

  # GET /tweeets/1 or /tweeets/1.json
  def show
  end

  # GET /tweeets/new
  def new
    # @tweeet = Tweeet.new
    @tweeet = current_user.tweeets.build
  end

  # GET /tweeets/1/edit
  def edit
  end

  # POST /tweeets or /tweeets.json
  def create
    @tweeet = current_user.tweeets.build(tweeet_params)

    respond_to do |format|
      if @tweeet.save
        # format.html { redirect_to tweeet_url(@tweeet), notice: "Tweeet was successfully created." }
        format.html { redirect_to root_path, notice: "Tweeet was successfully created." }
        format.json { render :show, status: :created, location: @tweeet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweeets/1 or /tweeets/1.json
  def update
    respond_to do |format|
      if @tweeet.update(tweeet_params)
        format.html { redirect_to root_path, notice: "Tweeet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweeet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeets/1 or /tweeets/1.json
  def destroy
    @tweeet.destroy

    respond_to do |format|
      format.html { redirect_to tweeets_url, notice: "Tweeet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def like
    # @tweeet = User.find(params[:id])
    # @tweeet.likes.create
    Like.create!(tweeet_id: params[:tweeet_id], user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end

  def dislike
    @tweeet = Like.where(tweeet_id: params[:tweeet_id], user_id: current_user.id)
    @tweeet.first.destroy
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweeet_params
      params.require(:tweeet).permit(:tweeet, :image)
    end
end
