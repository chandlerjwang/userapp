class UsersController < ApplicationController
  before_action :require_user_login, only: [:edit, :update, :show, :index, :destroy]
  before_action :require_correct_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.where(activated: true)
  end

  def show
    # @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render 'users/new'  
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # site authorization
    def require_user_login
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_path
      end
    end

    def require_correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
