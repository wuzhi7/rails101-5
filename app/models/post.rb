class Post < ApplicationRecord

  validates_presence_of :content

  belongs_to :user
  belongs_to :group

  scope :recent, -> { order("created_at DESC") }

end
