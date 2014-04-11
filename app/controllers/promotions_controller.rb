class PromotionsController < ApplicationController
    before_filter :authenticate_user!
    ensure_authorization_performed

  def show
    @promotion = Promotion.find(params[:id])
    authorize_action_for(@promotion)

    @students = @promotion.students
    @current_user = current_user
  end

  def leave
    promotion = Promotion.find(params[:id])
    authorize_action_for(promotion)
    promotion.leave(current_user)
    redirect_to :back
  end
  authority_actions :leave => 'update'

  def follow
    promotion = Promotion.find(params[:id])
    authorize_action_for(promotion)
    unless current_user.user_is_in(promotion)
      Follower.new(:user => current_user, :promotion => promotion, :accepted => false).save
    end
    redirect_to :back
  end
    authority_actions :follow => 'read'
end
