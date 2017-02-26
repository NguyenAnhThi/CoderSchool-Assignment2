class UsersController < ApplicationController
  def index
    @friends_id = current_user.friends.all.select(:id)
    @users = User.where.not(id: @friends_id).where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome, #{@user.name}!"
      session[:user_id] = @user.id
      redirect_to received_messages_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    @users = current_user.friends
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
