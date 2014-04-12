class DiscussionsController < ApplicationController
  before_filter :authenticate_user!
  ensure_authorization_performed

  def index
    discussions = current_user.discussions

    current_user.promotions.each do |promotion|
      discussions += promotion.discussions
      discussions += promotion.establishment.discussions
    end
    current_user.accepted_followed_promotions.each do |promotion|
      discussions += promotion.discussions
    end
    @discussion = Discussion.new
    @discussions = discussions.uniq
    @users_in_select = current_user.general_establishment.get_users

    @discussions.each do |di|
      authorize_action_for(di)
    end
  end

  def show
    @discussion = Discussion.find(params[:id])

    authorize_action_for(@discussion)

    @items = @discussion.get_items
    @event = Event.new
    @message = Message.new
    @promotion = nil
    @participants, @participants_follower = @discussion.fill_sidebar
    if @participants_follower.size != 0
      @promotion = @participants_follower[0].promotion
    end
    @current_user = current_user
  end

  def create
    user_ids = params[:discussion][:user_ids]

    # Remove empty string element (provided by and necessary for choosen)
    user_ids.delete("")

    # convert array elements from string to integers
    user_ids_int = user_ids.collect { |i| i.to_i }

    if user_ids_int.size == 0 || (user_ids_int.size == 1 && user_ids_int.include?(current_user.id))
      self.authorization_performed = true
      redirect_to :back and return
    end

    # append current user to the discussion
    user_ids_int.append(current_user.id).uniq!

    discussion_new = Discussion.new
    discussion_new.users = User.find(user_ids_int)

    d = Discussion.already_exists(discussion_new.users, [], [])
    if d.size == 1
      d = d[0]
      authorize_action_for(d)
      redirect_to d
    else
      authorize_action_for(discussion_new)
      discussion_new.save(:validate => false)
      redirect_to discussion_new
    end
  end
end
