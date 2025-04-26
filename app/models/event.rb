class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendances, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :attendances, source: :attendee

  scope :past, -> { where("date < ?", Time.current) }
  scope :future, -> { where("date >= ?", Time.current) }
end
