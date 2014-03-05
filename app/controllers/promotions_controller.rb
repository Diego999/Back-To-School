class PromotionsController < ApplicationController
  def show
    @promotion = Promotion.find(params[:id])
    @students = @promotion.students
  end
end
