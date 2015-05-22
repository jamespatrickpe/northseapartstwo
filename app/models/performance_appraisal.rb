class PerformanceAppraisal < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_presence_of :employee

  validates_length_of :description, maximum: 64
  validates_length_of :category, maximum: 64

  validates_numericality_of :score

end
