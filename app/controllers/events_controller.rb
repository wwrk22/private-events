class EventsController < ApplicationController

  before_action :set_event, only: [:show]

  def index
    @past_events = Event.past_events
    @future_events = Event.future_events
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
    # Get the event's host name.
    result = User.select('users.name').where('users.id' => @event.host_id)
    @host_name = result[0].name

    # Get all the event's attendants (should've really used the word "attendees" instead).
    @attendances = Attendance.where('attendances.attended_event_id' => @event.id).includes(:attendant)
  end

  private # ===========================================================================================================

  def event_params
    params.require(:event).permit(:name, :event_date, :event_location)
  end

  # Set the Event with given id for currently signed-in User.
  def set_event
    # This is a form of validation to make sure only an integer is used as the id in the query below.
    id = params[:id].to_i

    if id != 0
      result = Event.where('events.id' => id)

      if result.size == 1
        @event = result[0]
      else
        # Error: Event with given id does not exist.
      end
    else
      # Error: a string or nil was given as the id.
    end
  end

end
