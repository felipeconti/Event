module EventsHelper

	def unvoted_polls_user_count
    @count = 0
    @event.polls.each do |poll|
      if poll.votes(:voter => @user).size == 0
        @count += 1
      end
    end
    @count.to_s
	end

  def member_of?(event, user)
    # require "pry"; binding.pry
    event.users.include?(user)
  end
  
end
