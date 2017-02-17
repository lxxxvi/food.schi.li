class UsersController < ApplicationController

  before_action :authenticate_admin_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(user_params)
    return user_already_exists_error unless @user.new_record?
    @user.quick_password = SecureRandom.base64(32)

    if @user.valid?
      PasswordService.reset_link!(@user)
      flash.now[:success] = 'Invitation has been sent'
      render :show
    else
      flash.now[:warning] = 'Ooops, something went wrong'
      render :new
    end
  end

  def edit
    # todo
  end

  def update
    # todo
  end

  def destroy
    # todo
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def user_already_exists_error
    flash.now[:warning] = 'This user already exists'
    render :new
  end
end
