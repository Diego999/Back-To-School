class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @discussion = Discussion.find(params[:discussion_id])

    user = current_user#User.all[0]

    @message = @discussion.messages.new
    @message.text = params[:message].require(:text)
    @message.author = user
    @message.save

    redirect_to discussion_path(@discussion)
  end
end
