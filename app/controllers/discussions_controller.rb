class DiscussionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @discussions = current_user.discussions

    current_user.promotions.each do |promotion|
      @discussions += promotion.discussions
      @discussions += promotion.establishment.discussions
    end
    current_user.followers.each do |f|
      if f.accepted
        @discussions += f.promotion.discussions
      end
    end
    @discussion = Discussion.new
    @discussions.uniq #TODO : Need to be tested
  end

  def show
    @discussion = Discussion.find(params[:id])
    @items = @discussion.get_items
    @event = Event.new
    @message = Message.new
    @promotion = nil
    @participants, @participants_follower = @discussion.fill_sidebar
    if @participants_follower.size != 0
      @promotion = @participants_follower[0].promotion
    end
    @current_user = current_user
  end

  def create
    users = User.find(params[:users])
    promotions = params.has_key?(:promotions) ? Promotion.find(params[:promotions]) : []
    establishments = params.has_key?(:establishments) ? Establishment.find(params[:establishments]) : []

    if users.size == 1 && users[0].id == current_user.id
      redirect_to :back
    else
      d = Discussion.already_exists(users, promotions, establishments)
      if d.size == 1
        d = d[0]
      else
        d = Discussion.new
        d.users = users
        d.save
      end
      redirect_to d
    end
  end

  def accept
    Discussion.accept(current_user, User.find(params[:user]), Promotion.find(params[:promotion]))
    redirect_to :back
  end
end
