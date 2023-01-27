class Event < ApplicationRecord
  # An Event is hosted by a User.
  belongs_to :host, class_name: 'User'

  # An Event has many attendees(Users).
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendants, through: :attendances
end
