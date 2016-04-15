class InstitutionalAdjustment < ActiveRecord::Base



  validates_numericality_of :start_range, maximum: 16
  validates_numericality_of :end_range, maximum: 16
  validates_numericality_of :employee_contribution, maximum: 16
  validates_numericality_of :employee_contribution, maximum: 16

  validates_presence_of :start_range, :end_range, :employee_contribution, :employer_contribution, :institution, :contribution_type
  validates_length_of :remark , maximum: 256

end
