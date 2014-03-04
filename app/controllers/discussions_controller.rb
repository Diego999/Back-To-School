class DiscussionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @discussions = current_user.discussions

    current_user.promotions.each do |promotion|
      @discussions += promotion.discussions
      @discussions += promotion.establishment.discussions
    end

    @discussions.uniq #TODO : Need to be tested

  end

end
