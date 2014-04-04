class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @current_user = current_user
    @promotions = current_user.promotions

    @followed_promotions = []
    current_user.followers.each do |follow|
      @followed_promotions.append(follow.promotion)
    end
    @selected_promotion = params.has_key?(:id) ? Promotion.find(params[:id]) : current_user.get_default_promotion
    @promotion_students = @selected_promotion.students

    @promotion_followers = @selected_promotion.followers

    @discussion = @selected_promotion.get_discussion
    @items = @discussion.get_items

    @event = Event.new
    @message = Message.new
  end
end
