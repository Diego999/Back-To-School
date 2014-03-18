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
    @items = @discussion.get_items()
    @message = Message.new

    @participants, @participants_follower = @discussion.fill_sidebar()
  end


end
