class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @promotions = @user.promotions

    if @promotions.length <= 0
      raise ActionController::RoutingError.new('Not Found')
    end

    @establishment = current_user.get_default_promotion.establishment

    @followed_promotions = []
    @user.followers.each do |follow|
      @followed_promotions.append(follow.promotion)
    end
  end
end
