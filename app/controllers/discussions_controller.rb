class DiscussionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @discussions = Discussion.all
    authorize_action_for(@discussions)
  end

  def show
    @discussion = Discussion.find(params[:id])
    authorize_action_for(@discussion)

    @message = Message.new
  end

end
