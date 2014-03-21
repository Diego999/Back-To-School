class DiscussionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @discussions = current_user.discussions

    current_user.promotions.each do |promotion|
      @discussions += promotion.discussions
      @discussions += promotion.establishment.discussions
    end
    @discussion = Discussion.new
    @discussions.uniq #TODO : Need to be tested
  end

  def show
    @discussion = Discussion.find(params[:id])
    @items = @discussion.get_items
    @event = Event.new
    @message = Message.new

    @participants, @participants_follower = @discussion.fill_sidebar
  end

  def create
    users = User.find(params[:users])
    promotions = params.has_key?(:promotions) ? Promotion.find(params[:promotions]) : []
    establishments = params.has_key?(:establishments) ? Establishment.find(params[:establishments]) : []


    #redirect_to discussion
  end

  def accept
    Discussion.accept(current_user, User.find(params[:user]), Promotion.find(params[:promotion]))
    redirect_to :back
  end
end
