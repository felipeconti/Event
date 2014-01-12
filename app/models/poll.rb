class Poll < ActiveRecord::Base
  belongs_to :trip
  acts_as_votable
  sync :all
end
