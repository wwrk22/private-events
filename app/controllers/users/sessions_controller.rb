# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  # GET /my_info
  def show
    # This check is good candidate for separating out to be called by a filter method like #before_action.
    if user_signed_in?
      # Print the datetime in EDT zone.
      Time.zone = 'Eastern Time (US & Canada)'

      # This won't execute a query since the associated :hosted_events has already been loaded into memory.
      # In #set_user, the method #includes calls #preload to query the :hosted_events belonging to @user.
      @hosted_events = current_user.hosted_events

      # Get all the attendance records for the current user in order to list all the attended events.
      @attendances = Attendance.where('attendances.attendant_id' => current_user.id).includes(:attended_event)
    else
      # User is not signed in. This should be handled.
    end
  end


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

end
