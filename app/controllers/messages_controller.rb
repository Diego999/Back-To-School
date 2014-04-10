class MessagesController < ApplicationController
  before_filter :authenticate_user!
  ensure_authorization_performed

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @message = @discussion.messages.create(params[:message].permit(:message))
    @message.user = current_user

    authorize_action_for(@message)
    @message.save
    redirect_to :back
  end
end
