class PerformanceAppraisal < ActiveRecord::Base

  include BaseConcerns,
          EmployeeConcerns,
          RemarkConcerns

  validates_length_of :category, maximum: 64
  validates_numericality_of :score

end
