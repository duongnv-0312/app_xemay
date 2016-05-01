class User < ActiveRecord::Base
  ratyrate_rater

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def is_admin?
    self.role == "admin"
  end

  def is_normal_user?
    self.role == "normal"
  end
end
