class SearchesController < ApplicationController
    def show
        search_value = "%#{params[:search]}%" 
        band_name = "%#{params[:band_name]}%" 
        album_title = "%#{params[:album_title]}%"
        track_title = "%#{params[:track_title]}%"

        if params[:search].nil?
            @bands = params[:band_name] == "" ? [] : Band.where("name LIKE '#{band_name}'")
            @albums = params[:album_title] == "" ? [] : Album.where("title LIKE '#{album_title}'") 
            @tracks = params[:track_title] == "" ? [] : Track.where("title LIKE '#{track_title}'")
        else
            @bands = Band.where("name LIKE '#{search_value}'")
            @albums = Album.where("title LIKE '#{search_value}'")
            @tracks = Track.where("title LIKE '#{search_value}'")
        end

        if params[:tag] == "true"
            bands = []
                @bands = @bands.map { |band| bands << band unless band.tags.where(user_id: current_user.id).empty?}
            @bands = bands

            albums = []
                @albums = @albums.map { |album| albums << album unless album.tags.where(user_id: current_user.id).empty?}
            @albums = albums

            tracks = []
                @tracks.each { |track| tracks << track unless track.tags.where(user_id: current_user.id).empty?}
            @tracks = tracks
        
        elsif params[:tag] == "false"

            bands = []
                @bands = @bands.map { |band| bands << band if band.tags.where(user_id: current_user.id).empty?}
            @bands = bands
            
            albums = []
                @albums = @albums.map { |album| albums << album if album.tags.where(user_id: current_user.id).empty?}
            @albums = albums
            
            tracks = []
                @tracks.each { |track| tracks << track if track.tags.where(user_id: current_user.id).empty?}
            @tracks = tracks
        end

        render :show
    end
end