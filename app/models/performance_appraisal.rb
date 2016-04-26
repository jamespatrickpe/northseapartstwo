class PerformanceAppraisal < ActiveRecord::Base

  include BaseConcerns,
          Employee,
          Remark

  validates_length_of :category, maximum: 64
  validates_numericality_of :score

end
