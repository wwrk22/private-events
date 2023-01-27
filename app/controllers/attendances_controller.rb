class AttendancesController < ApplicationController
  def create
    @attendance = Attendance.new
    @attendance.attended_event_id = params[:event_id]
    @attendance.attendant_id = current_user.id

    if @attendance.save
      redirect_to current_user, notice: "You added an event to attend!"
    else
      redirect_to event_path(params[:event_id]), status: :unprocessable_entity
    end
  end
end
