class Expense < ActiveRecord::Base



  validates_numericality_of :amount
  validates_presence_of :category
  validates_presence_of :date_of_implementation

  validates_length_of :remark , maximum: 256, message: "remark must be less than 256 characters"
  validates_length_of :physical_id , maximum: 256, message: "remark must be less than 256 characters"

end
