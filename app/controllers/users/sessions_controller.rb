# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  before_action :set_user, only: [:show]

  # GET /users/:id
  def show
    if @user
      # Print the datetime in EDT zone.
      Time.zone = 'Eastern Time (US & Canada)'

      # This won't execute a query since the associated :hosted_events has already been loaded into memory.
      # In #set_user, the method #includes calls #preload to query the :hosted_events belonging to @user.
      @hosted_events = @user.hosted_events

      # Get all the attendance records for the current user in order to list all the attended events.
      @attendances = Attendance.where('attendances.attendant_id' => current_user.id).includes(:attended_event)
    else # User is not signed in.
      # For now, just redirect to avoid crashing.
      render :index, status: :ok
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


  private # ===========================================================================================================

  # Set the ActiveRecord::Relation for the User with the given URL param :id along with the associated :hosted_events.
  # If the User is not found, then @user_info is set to nil for the controller action to handle the error.
  def set_user
    # Strings and nil are converted to 0 UNLESS the string starts with a number, in which case the conversion will
    # work up until the first non-numeric character.
    # e.g. '123abc'.to_i # -> 123
    if user_signed_in?
      id = current_user.id
    else
      puts 'Sign in to see your events.'
    end

    if User.exists?(id) # Check validity of ID
      @result = User.select('users.id, users.name').where('users.id' => id).includes(:hosted_events)
      @user = @result[0]
    else
      @user = nil
    end
  end
end
