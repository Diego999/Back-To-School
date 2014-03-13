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
    @messages = @discussion.messages
    @events = @discussion.events
    @message = Message.new

    establishments = @discussion.establishments
    promotions = @discussion.promotions
    user = @discussion.users

    @participants = []
    @participants_follower = []
    establishments.each do |establishment|
      add_from_promotion(establishment.promotions)
    end

    add_from_promotion(promotions)
    @participants.concat(user)

    # We remove the user of follower if he is already in participants
    @participants.each do |p|
      @participants_follower.reject!{|f| f.user.id == p.id}
    end
  end

  def add_from_promotion(promotions)
    promotions.each do |promotion|
      @participants.concat(promotion.students)
      @participants_follower.concat(promotion.followers)
    end
  end

end
