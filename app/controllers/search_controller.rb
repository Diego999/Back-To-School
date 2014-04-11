class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    @promotions = Promotion.search(params[:search], current_user.general_establishment)
    @users = User.search(params[:search], current_user.general_establishment)
  end
end
