module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
        #store the id to the session to indicate logged in
    end
    
    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
        #remember both the user id and the random token stored in remember_token
    end
    
    #returns the current logged-in user, if any.
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
                        #find out the current user id by checking the session's id
    end
    # Returns the user corresponding to the remember token cookie.
    def current_user
        # “If session of user id exists (while setting user id to session of user id).."
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        #If there is user id in the session, use @current_user
        #If none, check the user id inside the cookies
        #If there is, 
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
    
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end
    
    # Logs out the current user.
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
    
    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    # Logs out the current user.
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
end
