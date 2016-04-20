class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # before_action :authenticate_user!
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def is_admin?
    self.role == 1
  end

  def is_normal_user?
    self.role == 0
  end
end
