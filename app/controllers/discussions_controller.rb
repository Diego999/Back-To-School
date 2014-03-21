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
    promotions = Promotion.find(params[:promotions])
    establishments = Establishment.find(params[:establishments])
  end

  def accept
    user = User.find(params[:user])
    promotion = Promotion.find(params[:promotion])

    follower = nil
    promotion.followers.each do |f|
      if f.user == user
        follower = f
      end
    end
    if promotion.students.exists?(current_user) and !follower.nil? and !follower.accepted
      follower.accepted = true
      follower.save
    end
    redirect_to :back
  end
end
