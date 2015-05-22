class InstitutionalAdjustment < ActiveRecord::Base

  include UUIDHelper

  belongs_to :institution_employee, :required => true

  validates_numericality_of :start_range, maximum: 16
  validates_numericality_of :end_range, maximum: 16
  validates_numericality_of :employee_contribution, maximum: 16
  validates_numericality_of :employee_contribution, maximum: 16

  validates_presence_of :start_range, :end_range, :employee_contribution, :employer_contribution
  validates_length_of :description , maximum: 256

end
