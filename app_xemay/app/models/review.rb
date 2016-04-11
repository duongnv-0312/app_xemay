class Review < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy

  has_one :store, dependent: :destroy
  belongs_to :user

  validates :content, presence: true

  accepts_nested_attributes_for :store, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:name].blank?}

  delegate :name, :address, :phone_number, to: :store,
    prefix: true, allow_nil: true
end
