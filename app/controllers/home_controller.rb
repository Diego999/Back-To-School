class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    promotions = current_user.promotions

    followed_promotions = []
    current_user.followers.each do |follow|
      followed_promotions.append(follow.promotion)
    end
    promotion_students = promotions[0].students

    promotion_followers = promotions[0].followers
    @data = {:promotions => promotions, :followed_promotions => followed_promotions, :promotion_students => promotion_students, :promotion_followers => promotion_followers}
  end
end
