class Review < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :marked_reviews, dependent: :destroy
  has_many :marked_by, through: :marked_reviews, source: :user

  has_one :store, dependent: :destroy
  belongs_to :user

  validates :content, presence: true

  accepts_nested_attributes_for :store, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:name].blank?}

  delegate :name, :address, :phone_number, :avg_rating, to: :store,
    prefix: true, allow_nil: true
end
