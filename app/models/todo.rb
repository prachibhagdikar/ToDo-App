class Todo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :todo_attachment, ProfileImageUploader
  validates :name, :date, :categories, presence: true
  validates_format_of :date, :reminder_date, :with => /\d{2}\/\d{2}\/\d{4}/, :message => "Date must be in the following format: mm/dd/yyyy"
  serialize :categories, Array
  CATEGORIES = { home: 0, work: 2, vacation: 3, urgent: 4, normal: 5, medical: 6, school: 7, college: 8 }
end
