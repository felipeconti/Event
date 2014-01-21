class Event < ActiveRecord::Base
	has_many :polls, :dependent => :delete_all
	has_many :items, :dependent => :delete_all
  has_many :comments, dependent: :destroy
end
