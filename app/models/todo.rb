class Todo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :todo_attachment, ProfileImageUploader
  validates :name, presence: true
  validates :date, presence: true
  serialize :categories, Array
  CATEGORIES = { home: 0, work: 2, vacation: 3, urgent: 4, normal: 5, medical: 6, school: 7, college: 8 }
end
