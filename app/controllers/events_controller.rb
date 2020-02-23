class EventsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    def index
        params[:tag] ? @events = Event.tagged_with(params[:tag]) : @events = Event.all
    end

    def new
        @event = Event.new
    end
    
    def create
        @event = Event.new(event_params)
        @event.admin_id = current_user.id

        if @event.save
            redirect_to event_path(@event)
        else
            render 'new'
        end
    end

    def show
        @event =  Event.find(params[:id])
    end

    private

    def event_params
        params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :admin_id, :tag, { tag_ids: [] }, :tag_ids)
    end
end
