class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase) 
    #pulls the user out of the database using the submitted email address.
    if @user && @user.authenticate(params[:session][:password]) 
    #matched with the submitted password returns true if correct
    
      #Log the user in and redirect to the user's show page.
      log_in @user
      #the value of checkbox is 1 if checked, so remember user
      #the value of checkbox is 0 if not checked, so forget user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email or password combination.'
      render 'new'
    end
  end
  
  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
