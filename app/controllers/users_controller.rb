class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def index
    @users = User.all
  end

  def new
  end

  def create
    if !User.valid_entry?(user_params)
      flash[:notice] = "Invalid entry in one of the text-boxes"
      redirect_to request.referrer
    elsif not User.find_by(username: user_params[:username]).blank?
      flash[:notice] = "Username, \'#{user_params[:username]}\' has already been taken"
      redirect_to request.referrer
    else
      @user = User.create_user!(user_params)
      flash[:notice] = "Account with Username \'#{user_params[:username]}\' has been created"
      redirect_to login_path
    end
  end

  def join_room?

  end

  def join_room
    @current_user.room_id = params[:user][:room_id]
    redirect_to room_path room_id
  end

end

