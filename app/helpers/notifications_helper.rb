module NotificationsHelper

	def unvoted_polls_user_count
    @count = 0
    @event.polls.each do |poll|
      if poll.votes(:voter => @user).size == 0
        @count += 1
      end
    end
    @count.to_s
	end

  def countNotifications
    Notification.where("user_id = #{current_user.id} and not viewed ").count
  end
  
end
