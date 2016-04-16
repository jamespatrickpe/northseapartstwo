class Expense < ActiveRecord::Base

  include BaseConcerns

  validates_presence_of :category
  validates_presence_of :datetime_of_implementation
  validates_length_of :physical_id , maximum: 256, message: "remark must be less than 256 characters"

end
