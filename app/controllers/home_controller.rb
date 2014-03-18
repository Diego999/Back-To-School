class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @promotions = current_user.promotions

    @followed_promotions = []
    current_user.followers.each do |follow|
      @followed_promotions.append(follow.promotion)
    end
    @promotion_students = current_user.get_default_promotion.students

    @promotion_followers = current_user.get_default_promotion.followers
  end
end
