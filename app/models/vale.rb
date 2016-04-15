class Vale < ActiveRecord::Base

  belongs_to :employee
  validates_length_of :amount, maximum: 64
  validates_length_of :remark , maximum: 256
  validates_presence_of :date_of_implementation, maximum: 256
  validates_presence_of :amount, maximum: 16
  validates_presence_of :amount_of_deduction, maximum: 16
  validates_presence_of :period_of_time, maximum: 64
  validates :approval_status, inclusion: { in: [true, false] }
end
