class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:success] = "Added friend!"
      redirect_to users_path
    else
      flash[:error] = "Unable to add friend!"
      redirect_to users_path
    end
  end

  def destroy
    @friendship = current_user.friendships.where(user_id: current_user, friend_id: params[:friend_id])
    current_user.friendships.destroy(@friendship)
    flash[:success] = "Removed friendship!"
    redirect_to user_path
  end
end
