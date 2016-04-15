class PerformanceAppraisal < ActiveRecord::Base



  belongs_to :employee
  validates_presence_of :employee

  validates_length_of :remark, maximum: 64
  validates_length_of :category, maximum: 64

  validates_numericality_of :score

end
