class Poll < ActiveRecord::Base
  belongs_to :event
  acts_as_votable
  sync :all
end
