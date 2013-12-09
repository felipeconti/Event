class Poll < ActiveRecord::Base
  acts_as_votable
  sync :all
end
