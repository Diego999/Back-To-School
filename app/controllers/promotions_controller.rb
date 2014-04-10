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
    Promotion.find(params[:id]).leave(current_user)
    redirect_to :back
  end

  def follow
    promotion = Promotion.find(params[:id])
    unless promotion.user_is_in(current_user)
      Follower.new(:user => current_user, :promotion => promotion, :accepted => false).save
    end
    redirect_to :back
  end
end
