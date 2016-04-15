class Leave < ActiveRecord::Base



  belongs_to :employee
  validates_presence_of :type_of_leave, :start_of_effectivity, :end_of_effectivity
  validates_length_of :remark , maximum: 256

end
