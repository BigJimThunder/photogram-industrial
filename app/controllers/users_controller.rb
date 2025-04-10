class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
  
    # Show incoming requests so the current user can see requests sent *to them* from the profile page they're viewing
    @incoming_requests = FollowRequest.where(recipient: current_user, status: "pending")
    @outgoing_request = FollowRequest.find_by(sender: current_user, recipient: @user)
  
    @followers = User.joins(:sent_follow_requests)
                     .where(follow_requests: { recipient_id: @user.id, status: "accepted" })
  
    @leaders = User.joins(:received_follow_requests)
                   .where(follow_requests: { sender_id: @user.id, status: "accepted" })
  end
  
  

  def liked
    @user = User.find_by!(username: params.fetch(:username))
  end

  def feed
    @user = User.find_by!(username: params.fetch(:username))
    @feed_photos = @user.feed
  end

  def discover
    @user = User.find_by!(username: params.fetch(:username))
    @discoverable_photos = @user.discover
  end

end
