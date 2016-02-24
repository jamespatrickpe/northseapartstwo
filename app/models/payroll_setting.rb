class PayrollSetting < ActiveRecord::Base

  include UUIDHelper
  belongs_to :employee
  validates_length_of :remark , maximum: 256, message: "description must be less than 256 characters"
  validates_presence_of :date_of_effectivity
  validates :applicability, inclusion: { in: [true, false] }

end
