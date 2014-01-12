class Item < ActiveRecord::Base
  belongs_to :trip
  sync :all
end
