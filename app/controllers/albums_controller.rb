class AlbumsController < ApplicationController
    before_action :require_current_user!
    before_action :require_current_user_admin!, except: [:show]

    def show
        @album = Album.find_by(id: params[:id])
        @band = Band.find_by(id: @album[:band_id])
        if @album
            render :show
        else
            redirect_to albums_url
        end
    end

    def new
        @bands = Band.select(:id, :name).all
        @band = Band.find_by(id: params[:band_id])
        @album = Album.new
        render :new
    end

    def create
        @album = Album.new(album_params)
        if @album.save
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            @bands = Band.select(:id, :name).all
            
            render :new, band: @album.band, bands: @bands
        end
    end

    def edit
        @bands = Band.select(:id, :name).all
        @album = Album.find_by(id: params[:id])
        @band = Band.find_by(id: @album[:band_id])
        render :edit
    end

    def update
        @album = Album.find_by(id: params[:id])
        if @album.update_attributes(album_params)
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            @bands = Band.select(:id, :name).all
            @band = @album.band
            
            render :edit, band: @band, bands: @bands
        end
    end

    def destroy
        @album = Album.find_by(id: params[:id])
        if @album.destroy
            redirect_to band_url(@album.band)
        else
            flash[:errors] = @album.errors.full_messages
            redirect_to band_url(@album.band)
        end
    end

    private
    def album_params
        params.require(:album).permit(:title, :year, :live, :band_id)
    end
end