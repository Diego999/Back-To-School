class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    keyword = params[:keyword]
    @search_active = keyword != nil
    if @search_active
      @promotions = Promotion.search(params[:keyword], current_user.general_establishment)
      @users = User.search(params[:keyword], current_user.general_establishment)
    end
  end
end
