class Todo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :todo_attachment, ProfileImageUploader
  validates :name, :date, :categories, :user, presence: true
  validates_format_of :date, with: /\d{4}\-\d{2}\-\d{2}/, message: 'Date must be in the following format: yyyy-mm-dd'
  serialize :categories, Array
  validates_format_of :reminder_date, with: /\d{4}\-\d{2}\-\d{2}/, message: 'Reminder date must be in the following format: yyyy-mm-dd', if: :reminder
  CATEGORIES = { home: 0, work: 2, vacation: 3, urgent: 4, normal: 5, medical: 6, school: 7, college: 8 }

  validate :validate_categories, :date_not_in_past
  validate :reminder_date_before_due_date, if: :reminder

  scope :completed, -> { where(is_done: true) }
  scope :pending, -> { where('date > ?', Date.today) }
  scope :between_dates, ->(from_date, to_date) { where('date between ? and ?', from_date, to_date) }



  def validate_categories
    if (invalid_categories = (categories - CATEGORIES.keys.map(&:to_s)))
      invalid_categories.each do |category|
        errors.add(:categories, category + " is not a valid category")
      end
    end
  end

  def date_not_in_past
    errors.add(:date, 'Due date can not be in the past') if date.present? && date.to_date < Date.today
  end

  def reminder_date_before_due_date
    if reminder_date.present? && date.present?
      if (reminder_date.to_date > date.to_date) || (reminder_date.to_date < Date.today)
        errors.add(:reminder_date, 'Reminder date should be before the due date and can not be in the past')
      end
    end
  end
end
