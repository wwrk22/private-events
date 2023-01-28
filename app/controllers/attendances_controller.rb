class AttendancesController < ApplicationController
  def create
    @attendance = Attendance.new

    if event_id_param != 0
      @attendance.attended_event_id = event_id_param
    else
      # Error: invalid id param was given and thus converted to a non-existent id of 0
    end
    
    if user_signed_in?
      @attendance.attendant_id = current_user.id
    else
      # Error: user must be signed in to provide this controller with id
    end

    if @attendance.save
      redirect_to '/my_info', notice: "You added an event to attend!"
    else
      redirect_to event_path(params[:event_id]), status: :unprocessable_entity
    end
  end

  private # ===========================================================================================================

  def event_id_param
    id = params.require(:event_id).to_i
  end
end
