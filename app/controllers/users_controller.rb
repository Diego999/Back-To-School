class UsersController < ApplicationController
  before_filter :authenticate_user!
  ensure_authorization_performed

  def show
    @user = User.find(params[:id])
    authorize_action_for(@user)


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
