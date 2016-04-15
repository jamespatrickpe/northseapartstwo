class DutyStatus < ActiveRecord::Base

  belongs_to :employee
  validates_length_of :remark , maximum: 256, message: "remark must be less than 256 characters"
  validates_presence_of :date_of_implementation
  validates :active, inclusion: { in: [true, false] }
end