class Event < ApplicationRecord
  # An Event is hosted by a User.
  belongs_to :host, class_name: 'User'

  # An Event has many attendees(Users).
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendants, through: :attendances

  # This is a clearer way of defining class methods by declaring out loud that the scope of the methods is the
  # singleton class of an instance of this class, Event.
  class << self
    
    # Return all events whose date and time have passed.
    def past_events
      
    end

    # Return all events whose date and time have NOT passed.
    def future_events

    end

  end

end
