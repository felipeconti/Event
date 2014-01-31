class Event < ActiveRecord::Base
  has_many :polls, :dependent => :delete_all
  has_many :items, :dependent => :delete_all
  has_many :comments, dependent: :destroy

  has_many :holders
  has_many :users, through: :holders

  before_destroy {|event| event.users.clear}
end
