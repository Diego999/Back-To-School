class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    discussions = [Discussion.joins([:users]).where('users.id = ?', current_user)]

    current_user.promotions.each do |promotion|
      discussions.append(Discussion.joins([:promotions]).where('promotions.id = ?', promotion))
    end

    discussions.append(Discussion.joins([:establishments]).where('establishments.id = ?', current_user.promotions[0].establishment))

    @events = []
    discussions.each do |d|
      d.each do |dd|
        @events.concat(dd.events)
      end
    end

    @events.sort!{|a,b| a.date <=> b.date}
    @events.uniq!
  end

  def show
  end
end
