class ChatroomsController < ApplicationController
	before_action :require_user_login, only: [:index, :new, :create, :show]

	def index
		@chatrooms = Chatroom.all
	end

	def new
		@chatroom = Chatroom.new
	end

	def create
		@chatroom = Chatroom.new(chatroom_params)
		if @chatroom.save
			flash[:success] = "Chatroom created!"
			redirect_to @chatroom
		else
			render 'new'
		end
	end

	def show
		@chatroom = Chatroom.find_by(id: params[:id])
		@message = Message.new
	end

	def destroy
		Chatroom.find_by(id: params[:id]).destroy
		flash[:success] = "Chatroom deleted"
		redirect_to chatrooms_path
	end


	private

		def chatroom_params
			params.require(:chatroom).permit(:topic)
		end

	# site authorization
	def require_user_login
	  unless logged_in?
	    flash[:danger] = "Please log in"
	    redirect_to login_path
	  end
	end  	
end
