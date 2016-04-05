class Review < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy

  has_one :store
  belongs_to :user
end
