class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = current_user.get_all_events.uniq
  end

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @event = @discussion.events.create(params[:event].permit(:name,:location,:date))
    @event.user = current_user
    @event.save
    redirect_to discussion_path(@discussion)
  end
end
