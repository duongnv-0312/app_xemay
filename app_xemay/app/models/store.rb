class Store < ActiveRecord::Base
  ratyrate_rateable "quality"

  belongs_to :review

  has_one :coordinate, dependent: :destroy

  has_many :products, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :coordinate, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :products, allow_destroy: true

  delegate :lat, :lng, to: :coordinate, prefix: true, allow_nil: true

  scope :top_ten_rate, ->{order("avg_rating ASC, created_at DESC").first(10)}
end
