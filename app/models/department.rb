class Department < ActiveRecord::Base



  validates_length_of :remark , maximum: 256
  validates_length_of :label , maximum: 64
  has_many :positions

end
