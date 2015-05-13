class PerformanceAppraisal < ActiveRecord::Base

  belongs_to :employee
  validates_presence_of :employee

  validates_length_of :description, maximum: 64, message: "description must be less than 64 characters"
  validates_length_of :category, maximum: 64, message: "category must be less than 64 characters"

  validates_numericality_of :score

end
