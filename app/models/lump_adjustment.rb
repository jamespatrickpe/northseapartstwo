class LumpAdjustment < ActiveRecord::Base

  belongs_to :employee
  validates_length_of :amount, maximum: 64
  validates_length_of :remark , maximum: 256
  validates_presence_of :date_of_implementation, maximum: 256
  validates :signed_type, inclusion: { in: [true, false] }
end
