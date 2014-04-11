class DiscussionsController < ApplicationController
  before_filter :authenticate_user!
  ensure_authorization_performed

  def index
    discussions = current_user.discussions

    current_user.promotions.each do |promotion|
      discussions += promotion.discussions
      discussions += promotion.establishment.discussions
    end
    current_user.accepted_followed_promotions.each do |promotion|
        discussions += promotion.discussions
    end
    @discussion = Discussion.new
    @discussions = discussions.uniq

    @discussions.each do |di|
      authorize_action_for(di)
    end
  end

  def show
    @discussion = Discussion.find(params[:id])

    authorize_action_for(@discussion)

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

        authorize_action_for(d)

        d.save
      end
      redirect_to d
    end
  end

  def accept
    promotion = Promotion.find(params[:promotion])
    authorize_action_for(promotion)

    promotion.accept(current_user, User.find(params[:user]))

    redirect_to :back
  end
  authority_actions :accept => 'update'
end
