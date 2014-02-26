class DiscussionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @discussions = Discussion.all
  end

  def show
    @discussion = Discussion.find(params[:id])
    @message = Message.new
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def update
    @discussion = Discussion.find(params[:id])
    if discussion.update(get_params)
      redirect_to @discussion
    else
      remder 'edit'
    end
  end

end
