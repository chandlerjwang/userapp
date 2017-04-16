class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember(user) if params[:session][:remember_me] == '1'
        redirect_to user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
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
