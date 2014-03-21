class PromotionsController < ApplicationController
  def show
    @promotion = Promotion.find(params[:id])
    @students = @promotion.students
  end

  def leave
    Promotion.find(params[:id]).leave(current_user)
    redirect_to :back
  end
end
