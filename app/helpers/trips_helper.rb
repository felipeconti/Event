module TripsHelper
	def polls_count
		@trip.polls.count.to_s
	end
end
