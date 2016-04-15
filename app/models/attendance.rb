class Attendance < ActiveRecord::Base



  belongs_to :employee
  validates_length_of :remark , maximum: 256

end
