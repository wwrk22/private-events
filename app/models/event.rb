class Event < ApplicationRecord
  # An Event is hosted by a User.
  belongs_to :host, class_name: 'User'
end
