class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = current_user.get_all_events.uniq
  end
end
