class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, foreign_key: "creator_id", dependent: :destroy

  has_many :attendances, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :attendances, source: :attended_event

  has_many :invitations, dependent: :destroy
  has_many :event_invitations, through: :invitations, source: :event

  def attending?(event)
    attended_events.include?(event)
  end
end
