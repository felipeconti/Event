class Item < ActiveRecord::Base
  belongs_to :event
  sync :all
end
