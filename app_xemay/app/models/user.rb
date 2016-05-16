class User < ActiveRecord::Base
  ratyrate_rater

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, dependent: :destroy
  has_many :marked_reviews, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :markings, through: :marked_reviews, source: :review

  mount_uploader :avatar, ImageUploader

  def is_admin?
    self.role == "admin"
  end

  def is_normal_user?
    self.role == "normal"
  end

  def mark review
    marked_reviews.create review_id: review.id
  end

  def unmark review
    marked_reviews.find_by(review_id: review.id).destroy
  end

  def markings? review
    markings.include? review
  end
end
