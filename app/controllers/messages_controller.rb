class MessagesController < ApplicationController
  before_action :require_user_login

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast 'room_channel',
                             content:  message.content,
                             name: message.user.name
      # flash[:success] = "message submitted"
      # redirect_to message.chatroom
    else 
      redirect_to chatrooms_path
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id)
    end  
end
