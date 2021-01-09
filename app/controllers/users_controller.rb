class UsersController < ApplicationController
    before_action :require_current_user!, except: [:create, :new, :activate]

    def create
        @user = User.new(user_params)
        @user.set_activation_token

        if @user.save
            msg = UserMailer.welcome_email(@user)
            msg.deliver_now
            flash[:notices] ||= []
            flash[:notices] << "An email has been sent to your email. Activate your account with the link provided."
            
            redirect_to root_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def show

        if current_user.nil?
            redirect_to new_session_url
            return
        end

        @user = current_user
        render :show
    end

    def activate
        @user = User.find_by(activation_token: params[:activation_token])
        @user.activate_account!
        redirect_to new_session_url
    end

    protected

    def user_params
        self.params.require(:user).permit(:email, :password)
    end
end