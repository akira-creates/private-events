class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @creator = User.find(@event.creator_id)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_path, notice: "Event was successfully deleted."
    else
      redirect_to @event, alert: "Failed to delete the event."
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :date)
  end
end
