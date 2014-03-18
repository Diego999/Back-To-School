class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @message = @discussion.messages.create(params[:message].permit(:message))
    @message.user = current_user
    @message.save
    redirect_to discussion_path(@discussion)
  end
end
