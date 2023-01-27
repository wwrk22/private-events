class EventsController < ApplicationController
  def index
  end

  def new
    @event = Event.new
  end

  def create
    if user_signed_in?
      @event = current_user.hosted_events.build(event_params)
    else # Can't perform action if user isn't signed in.
      # For now, use an empty Event for redirecting below.
      @event = Event.new
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to '/my_info', notice: "Added new event to host: #{@event.name}" }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    
  end

  private # ===========================================================================================================

  def event_params
    params.require(:event).permit(:name, :event_date, :event_location)
  end

  def set_event
    id = params[:id].to_i

    if id != 0
      @event = Event.where('events.id' => id)
    else
      # Error a string or nil was given as the id.
    end
  end
end
