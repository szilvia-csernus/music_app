class NotesController < ApplicationController
    before_action :require_current_user!

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @track = Track.find_by(id: params[:note][:track_id])
        
        if @note.save
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @note.errors.full_messages
            redirect_to track_url(@track) 
        end
    end

    def destroy
        @note = Note.find_by(id: params[:id])
        @track = @note.track
        unless (current_user.id == @note.user_id) || current_user_admin?
            flash[:errors] ||= []
            flash[:errors] << "Access denied to erase comment! status: 403 FORBIDDEN"
            redirect_to track_url(@track)
            return
        end
        if @note.destroy
            redirect_to track_url(@track)
        else
            flash[:errors] = @note.errors.full_messages
            redirect_to track_url(@track)
        end
    end

    private
    def note_params
        params.require(:note).permit(:text, :track_id, :user_id)
    end
end