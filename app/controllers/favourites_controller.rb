class FavouritesController < ApplicationController
  before_action :set_user
  before_action :set_user_favourite, only: [:show, :update, :destroy]

  # GET /users/:user_id/favourites
  def index
    json_response(@user.favourites)
  end

  # GET /users/:user_id/favourites/:id
  def show
    json_response(@favourite)
  end

  # POST /users/:user_id/favourites
  def create
    @user.favourites.create!(favourite_params)
    json_response(@user, :created)
  end

  # PUT /users/:user_id/favourites/:id
  def update
    @favourite.update(favourite_params)
    head :no_content
  end

  # DELETE /users/:user_id/favourites/:id
  def destroy
    @favourite.destroy
    head :no_content
  end

  private

  def favourite_params
    params.permit(:name)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_favourite
    @favourite = @user.favourites.find_by!(id: params[:id]) if @user
  end
end
