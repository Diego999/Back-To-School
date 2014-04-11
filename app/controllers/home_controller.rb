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
    current_user.accepted_followed_promotions.each do |promotion|
      @followed_promotions.append(promotion)
    end
    @selected_promotion = params.has_key?(:id) ? Promotion.find(params[:id]) : current_user.get_default_promotion
    authorize_action_for(@selected_promotion)

    @promotion_students = @selected_promotion.students

    @promotion_followers = @selected_promotion.followers

    #We use it this way because it would ask too much work. Nothing assure there is minimum 1 discussion.
    #In our case, this is OK because we cannot create promotion and so forget creating the associated discussion
    @discussion = @selected_promotion.get_discussion[0]
    authorize_action_for(@discussion)

    @items = @discussion.get_items

    @event = Event.new
    @message = Message.new
  end
end
