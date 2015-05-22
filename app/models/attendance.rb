class Attendance < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_length_of :description , maximum: 256

end
