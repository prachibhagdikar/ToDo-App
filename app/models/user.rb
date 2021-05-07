class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :todos
  mount_uploader :profile_image, ProfileImageUploader
  enum gender: {male: 0, female: 1, other: 2 }
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :address, presence: true
  validates :profile_image, presence: true
end
