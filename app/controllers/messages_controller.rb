class MessagesController < ApplicationController
  def new
    @message = Message.new
    @friends = current_user.friends
  end

  def show
    @message = Message.where(recipient: current_user).find params[:id]
    if !@message.read?
      @message.mark_as_read!
    end
  end

  def sent
    load_user
    @messages = @user.sent_messages
  end

  def received
    load_user
    @messages = @user.received_messages
  end

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

  def create
    @message = Message.new message_params
    @message.sender = current_user
    if @message.save
      flash[:success] = "Your message has been sent"
      redirect_to sent_messages_path
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :body, :subject)
  end
end
