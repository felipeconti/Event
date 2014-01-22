class Event < ActiveRecord::Base
	has_many :polls, :dependent => :delete_all
	has_many :items, :dependent => :delete_all
  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :users
  before_destroy {|event| event.users.clear}
end
