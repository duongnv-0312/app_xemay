class Review < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy

  belongs_to :store
  belongs_to :user
end
