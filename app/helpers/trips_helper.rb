module TripsHelper

	def unvoted_polls_user_count
    @count = 0
    @trip.polls.each do |poll|
      if poll.votes(:voter => @user).size == 0
        @count += 1
      end
    end
    @count.to_s
	end

end
