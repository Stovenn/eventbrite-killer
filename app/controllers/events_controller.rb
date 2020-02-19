class EventsController < ApplicationController
    def index
        @events = Event.all
    end

    def new
        @event = Event.new
    end
    
    def create
        @event = Event.new(event_params)
        puts @event.title
        puts @event.description
        puts @event.start_date
        puts @event.duration
        puts @event.price
        puts @event.location
        if @event.save
            redirect_to "events#index"
        else
            render 'new'
        end
    end

    def show
        @event =  Event.find(params[:id])
    end

    private

    def event_params
        params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
    end
end
