class Vale < ActiveRecord::Base
  include UUIDHelper

  belongs_to :employee
  validates_presence_of :employee
  validates_numericality_of :amount
  validates_length_of :description, maximum: 128, message: "Description must be less than 128 characters"

  validates_length_of :rate_of_time, maximum: 32, message: "Period or Rate of Time must be less than 32 characters"
  validates_numericality_of :rate_of_payment, message: "Must be a number"

end
