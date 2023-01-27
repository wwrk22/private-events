class EventsController < ApplicationController
  def index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params())

    if user_signed_in?
      @event.host_id = current_user.id
    else
      # Event.host_id is left as nil for now.
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to current_user, notice: "Added new event to host: #{@event.name}" }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private # ===========================================================================================================

  def event_params
    params.require(:event).permit(:name, :event_date, :event_locations)
  end
end
