class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
  	else
  		flash.now[:danger] = "Invalid email or password, try again"
  		render 'new'
  	end
  end

  def destroy
    log_out
    flash[:success] = "see you next time!"
    redirect_to root_path  	
  end
end
