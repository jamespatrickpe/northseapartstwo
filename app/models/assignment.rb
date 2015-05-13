class Assignment < ActiveRecord::Base

  belongs_to :employee
  belongs_to :branch

  validates_length_of :task, maximum: 64

end
