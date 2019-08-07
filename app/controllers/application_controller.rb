class ApplicationController < ActionController::Base

    def current_user
        User.find_by(session_token: session[:session_token])
    end
    
    def login!(user)
        session[:session_token] = user.reset_token!
    end

    def logout!(user)
        session[:session_token] = nil
        user.reset_token!
    end
end
