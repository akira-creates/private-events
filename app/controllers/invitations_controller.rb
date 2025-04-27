class InvitationsController < ApplicationController
  before_action :set_event, only: [ :new, :create ]
  before_action :set_invitation, only: [ :update, :destroy ]

  def new
    @invitation = @event.invitations.new
    @users = User.where.not(id: [ @event.creator_id ] + @event.invited_users.pluck(:id))
  end

  def create
    @invitation = @event.invitations.new(invitation_params)
    if @invitation.save
      redirect_to @event, notice: "Invitation sent!"
    else
      render :new
    end
  end

  def update
    if params[:status] == "accepted"
      attendance = @invitation.event.attendances.build(attendee: current_user)
      @invitation.accepted!
      if attendance.save
        redirect_to @invitation.event, notice: "You've joined the event!"
      else
        redirect_to invitations_path, alert: "Couldn't join the event: #{attendance.errors.full_messages.to_sentence}"
      end

    elsif params[:status] == "declined"
      @user = @invitation.user
      @invitation.destroy
      redirect_to user_path(current_user), notice: "Invitation declined"
    else
      redirect_to user_path(current_user), alert: "Invalid action"
    end
  end

  def destroy
    @invitation.destroy
    redirect_to event_path(@invitation.event), notice: "Invitation deleted"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invitation
    @invitation = current_user.invitations.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:user_id)
  end
end
