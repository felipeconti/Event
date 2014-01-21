class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event, counter_cache: true

  validates_presence_of :message

  sync :all, scope: :event

  scope :ordered, -> { order("created_at ASC") }
  scope :recently_updated, -> { order("updated_at DESC")}

  def to_s
    self.message
  end
end
