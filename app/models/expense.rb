class Expense < ActiveRecord::Base

  include UUIDHelper

  has_and_belongs_to_many :actors

  validates_numericality_of :amount
  validates_presence_of :category
  validates_presence_of :date_of_effectivity

  validates_length_of :remark , maximum: 256, message: "description must be less than 256 characters"
  validates_length_of :physical_id , maximum: 256, message: "description must be less than 256 characters"

end
