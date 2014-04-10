class EventsController < ApplicationController
  before_filter :authenticate_user!
  ensure_authorization_performed

  def index
    @events = current_user.get_all_events.uniq

    @events.each do |event|
      authorize_action_for(event)
    end
  end

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @event = @discussion.events.create(params[:event].permit(:name,:location,:date))
    @event.user = current_user

    authorize_action_for(@event)
    @event.save
    redirect_to :back
  end
end
