class MessagesController < ApplicationController
  before_action :require_user_login

  def create
    message = current_user.messages.build(message_params)
    image_tag = gravatar_image_tag message, size: 50
    name_link_tag  = helpers.link_to message.user.name, message.user
    if message.save
      ActionCable.server.broadcast 'room_channel',
                             content:  message.content,
                             name_link_tag: name_link_tag,
                             user_id: message.user.id,
                             image_tag: image_tag
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

    def gravatar_image_tag(message, options = { size: 80 })
      gravatar_id = Digest::MD5::hexdigest(message.user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      helpers.image_tag gravatar_url, alt: message.user.name, class: "gravatar"
    end
end
