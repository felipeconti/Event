module ApplicationHelper

  def user_can_modify?(event)
  	# require "pry"; binding.pry
    current_user.super_user or (event and 
                                current_user.holders.find_by_event_id(event) and 
                                current_user.holders.find_by_event_id(event).edit)
  end
end
