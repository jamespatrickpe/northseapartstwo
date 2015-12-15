class Attendance < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_length_of :remark , maximum: 256

end
