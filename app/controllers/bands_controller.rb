class BandsController < ApplicationController
    before_action :require_current_user!
    before_action :require_current_user_admin!, except: [:index, :show,]

    def index
        @bands = Band.all
        render :index
    end

    def show
    
        if @band = Band.find_by(id: params[:id])
            # tagging_type accepts string
            @tag = Tag.find_by(user_id: current_user.id, tagging_id: @band.id, tagging_type: @band.class.to_s) 
        
            render :show
        else
            @bands = Band.all
            redirect_to bands_url
        end
    end

    def new
        @band = Band.new
        render :new
    end

    def create
        @band = Band.new(band_params)
        if @band.save
            redirect_to bands_url
        else
            flash.now[:errors] = @band.errors.full_messages
            render :new
        end
    end

    def edit

        if @band = Band.find_by(id: params[:id])
            render :edit
        else
            @bands = Band.all
            redirect_to bands_url
        end
    end

    def update
        @band = Band.find_by(id: params[:id])
        if @band.update_attributes(band_params)
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :edit
        end
    end

    def destroy
        if @band = Band.find_by(id: params[:id])
            if @band.destroy
                redirect_to bands_url
            else
                flash[:errors] = @band.errors.full_messages
                redirect_to band_url(@band)
            end
        else
            @bands = Band.all
            redirect_to bands_url
        end
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end