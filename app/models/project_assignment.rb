class ProjectAssignment < ActiveRecord::Base

  belongs_to :employee
  validates_presence_of :employee

  validates_length_of :department, maximum: 128, message: "Department must be less than 128 characters"
  validates_length_of :position, maximum: 128, message: "Position must be less than 128 characters"
  validates_length_of :task, maximum: 128, message: "Task must be less than 128 characters"

end
