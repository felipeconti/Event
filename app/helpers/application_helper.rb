module ApplicationHelper

  def user_can_modify?(event)
  	# require "pry"; binding.pry
    unless current_user.super_user or 
           (event and current_user.holders.find_by_event_id(event) and
            current_user.holders.find_by_event_id(event).edit)
      false
    else
  	  true
    end
  end
end
