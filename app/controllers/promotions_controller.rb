class PromotionsController < ApplicationController
  def show
    @promotion = Promotion.find(params[:id])
    @students = @promotion.students
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
