class ApplicationController < ActionController::Base
    
    helper_method :current_user, :current_user_admin?
    
    def current_user
        return nil if self.session[:session_token].nil?
        @user ||= User.find_by(session_token: self.session[:session_token])
    end

    def current_user_admin?
        current_user.admin?
    end

    def require_current_user_admin!
        unless current_user_admin?
            flash[:notices] ||= []
            flash[:notices] << "Access Denied!"
            redirect_to root_url
        end
    end

    def logged_in?
        current_user ? true : false
    end

    def require_current_user!
        redirect_to new_session_url if current_user.nil?
    end

    def log_in!(user)
        if user.activated
            user.reset_session_token!
            self.session[:session_token] = user.session_token
        end
        false
    end

    def log_out!
        current_user.try(:reset_session_token!)
        self.session[:session_token] = nil
    end
end
