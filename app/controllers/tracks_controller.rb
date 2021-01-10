class TracksController < ApplicationController
    before_action :require_current_user!
    before_action :require_current_user_admin!, except: [:show]

    def show
        @track = Track.find_by(id: params[:id])
        @album = Album.find_by(id: @track[:album_id])
        @tag = Tag.find_by(user_id: current_user.id, tagging_id: @track.id, tagging_type: @track.class.to_s)
        @notes = @track.notes
        
        if @track
            render :show
        else
            redirect_to tracks_url
        end
    end

    def new
        @album = Album.find_by(id: params[:album_id])
        band = @album.band
        @albums = band.albums.select(:id, :title).all
        
        @track = Track.new
        render :new
    end

    def create
        @track = Track.new(track_params)
        if @track.save
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            @albums = Album.select(:id, :title).all
            @album = @track.album
            
            render :new
        end
    end

    def edit
        @albums = Album.select(:id, :title).all
        @track = Track.find_by(id: params[:id])
        @album = Album.find_by(id: @track[:album_id])
        render :edit
    end

    def update
        @track = Track.find_by(id: params[:id])
        if @track.update_attributes(track_params)
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            @albums = Album.select(:id, :title).all
            @album = @track.album
            
            render :edit, album: @album, albums: @albums
        end
    end

    def destroy
        @track = Track.find_by(id: params[:id])
        if @track.destroy
            redirect_to album_url(@track.album)
        else
            flash[:errors] = @track.errors.full_messages
            redirect_to album_url(@track.album)
        end
    end

    private
    def track_params
        params.require(:track).permit(:title, :ord, :lyrics, :bonus, :album_id)
    end
end