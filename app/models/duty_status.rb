class DutyStatus < ActiveRecord::Base
  include UUIDHelper
  belongs_to :employee
  validates_length_of :remark , maximum: 256, message: "description must be less than 256 characters"
  validates :active, inclusion: { in: [true, false] }
end