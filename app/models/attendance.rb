class Attendance < ActiveRecord::Base

  belongs_to :employee
  validates_length_of :description , maximum: 256, message: "description must be less than 256 characters"

end
