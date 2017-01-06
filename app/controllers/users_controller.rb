class UsersController < ApplicationController
  def homepage
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def show
    if session[:user_id]
      @user = User.find(params[:id])
      if params[:attraction_id]
        @attraction = Attraction.find(params[:attraction_id])
        @ride = Ride.create(user_id: @user.id, attraction_id: @attraction.id)
        @user = @ride.take_ride
        if @user.is_a? User
          flash[:notice] = "Thanks for riding the #{@attraction.name}!"
        else
          flash[:notice] = @user
          @user = User.find(params[:id])
        end
      end
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
  end
end
