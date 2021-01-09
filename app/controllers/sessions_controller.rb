class SessionsController < ApplicationController

    def create
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        unless @user && @user.activated?
            flash.now[:notices] ||= []
            flash.now[:notices] << "Can't find this user."

            render :new
        else
            log_in!(@user)
            redirect_to bands_url
        end
    end

    def new
        render :new
    end

    def destroy
        log_out!
        flash[:notices] ||= []
        flash[:notices] << "You logged out. See you soon!"
        redirect_to new_session_url
    end
end