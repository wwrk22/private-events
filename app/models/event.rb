class Event < ApplicationRecord
  # An Event is hosted by a User.
  belongs_to :host, class_name: 'User'

  # An Event has many attendees(Users).
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendants, through: :attendances

  # Scopes to get past and future events separately.
  scope :past_events, -> { where('events.event_date <= ?', Time.now).includes(:host) }
  scope :future_events, -> { where('events.event_date > ?', Time.now).includes(:host) }

  # These two class methods serve the same purpose as the two scopes defined above. Generally, class methods are
  # preferred when a scope is too big to be defined as such.
  # This is a clearer way of defining class methods by declaring out loud that the scope of the methods is the
  # singleton class of an instance of this class, Event.
  # class << self
    
  #   # Return all events whose date and time have passed.
  #   def past_events
  #     Event.where('events.event_date <= ?', Time.now).includes(:host)
  #   end

  #   # Return all events whose date and time have NOT passed.
  #   def future_events
  #     Event.where('events.event_date > ?', Time.now).includes(:host)
  #   end

  # end

end
