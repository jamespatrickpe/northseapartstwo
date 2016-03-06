class Loan < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_presence_of :loan_type
  validates_presence_of :pagibig_employer_id_number
  validates_presence_of :employer_name
  validates_presence_of :employer_business_name
  validates_presence_of :employer_business_address
  validates_presence_of :employee_id
  validates_presence_of :borrower_name
  validates_presence_of :loan_value
  validates_presence_of :loan_remaining
  validates_presence_of :collection_period_from
  validates_presence_of :collection_period_to
  validates_presence_of :monthly_installment

  validates_numericality_of :loan_value
  validates_numericality_of :monthly_installment

  validates_length_of :remark , maximum: 256

end
