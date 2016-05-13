class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :content, presence: true, length: { maximum: 10000 }
  delegate :name, :avatar, to: :user, prefix: true, allow_nil: true
end
