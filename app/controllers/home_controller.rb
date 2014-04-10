class HomeController < ApplicationController
  before_filter :authenticate_user!
  ensure_authorization_performed

  def index
    @current_user = current_user
    @promotions = current_user.promotions

    @promotions.each do |prom|
      authorize_action_for(prom)
    end

    @followed_promotions = []
    current_user.followers.each do |follow|
      @followed_promotions.append(follow.promotion)
    end
    @selected_promotion = params.has_key?(:id) ? Promotion.find(params[:id]) : current_user.get_default_promotion
    authorize_action_for(@selected_promotion)

    @promotion_students = @selected_promotion.students

    @promotion_followers = @selected_promotion.followers

    #TODO: Ahhhh this is fucking dangerous!!! remove this direct access.
    # who ensures that at least one discussion is present? greetings from MAE
    @discussion = @selected_promotion.get_discussion[0]
    authorize_action_for(@discussion)

    @items = @discussion.get_items

    @event = Event.new
    @message = Message.new
  end
end
