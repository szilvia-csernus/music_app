class TagsController < ApplicationController

    def create

        @tag = Tag.new
        @tag.user_id = current_user.id
        
        case
            when params.has_key?(:band_id)
                @tag.tagging_id = params[:band_id]
                @tag.tagging_type = "Band"
            when params.has_key?(:album_id)
                @tag.tagging_id = params[:album_id]
                @tag.tagging_type = "Album"
            when params.has_key?(:track_id)
                @tag.tagging_id = params[:track_id]
                @tag.tagging_type = "Track"
        end

        if @tag.save
            flash[:notices] ||= []
            flash[:notices] << "Successfully tagged by #{current_user.email}"
            redirect_back(fallback_location: root_url)
        else
            flash[:errors] = @tags.errors.full_messages
            redirect_back(fallback_location: root_url)
        end
    end

    def destroy
        @tag = Tag.find_by(id: params[:id])
        if @tag.destroy
            flash[:notices] ||= []
            flash[:notices] << "Tag removed by #{current_user.email}"
            redirect_back(fallback_location: root_url)
        else
            flash[:errors] = @tags.errors.full_messages
            redirect_back(fallback_location: root_url)
        end
    end
end