class MessagesController < ApplicationController
  def create
    @discussion = Discussion.find(params[:discussion_id])
    #TODO: replace by current_user
    user = User.all[0]

    @message = @discussion.messages.new
    @message.text = params[:message].require(:text)
    @message.author = user
    @message.save

    redirect_to discussion_path(@discussion)
  end
end
