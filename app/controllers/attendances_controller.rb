class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :create, :destroy ]

  def create
    @attendance = current_user.attendances.build(attended_event_id: @event.id)
    if @attendance.save
      redirect_to @event, notice: "Successfully joined the event."
    else
      redirect_to @event, alert: "Failed to join the event."
    end
  end

  def destroy
    @attendance = current_user.attendances.find_by(attended_event_id: @event.id)
    if @attendance.destroy
      redirect_to @event, notice: "Successfully left the event."
    else
      redirect_to @event, alert: "Failed to leave the event."
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
