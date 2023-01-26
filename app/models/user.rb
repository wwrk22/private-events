class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # A User can be the host of an event.
  has_many :hosted_events, foreign_key: :host_id, class_name: 'Event'

end
