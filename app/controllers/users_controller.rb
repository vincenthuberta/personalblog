class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
    #we need to know which user to show
  end
  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Thanks for being my blog's member!"
        redirect_to @user
      else
        render 'new'
      end
  end
  
  private
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
