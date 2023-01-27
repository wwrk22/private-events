class Attendance < ApplicationRecord
  belongs_to :attended_event, class_name: 'Event'
  belongs_to :attendant, class_name: 'User'
end
