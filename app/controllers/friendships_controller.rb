class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @inverse_friendship = User.find(params[:friend_id]).friendships.build(friend_id: current_user.id)
    if @friendship.save and @inverse_friendship.save
      flash[:success] = "Added friend!"
      redirect_to users_path
    else
      flash[:error] = "Unable to add friend!"
      redirect_to users_path
    end
  end

  def destroy
    @friendship = current_user.friendships.where(user_id: current_user, friend_id: params[:friend_id])
    @inverse_friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)
    current_user.friendships.destroy(@friendship)
    User.find(params[:friend_id]).friendships.destroy(@inverse_friendship)
    flash[:success] = "Removed friendship!"
    redirect_to user_path
  end
end
