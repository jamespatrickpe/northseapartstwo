class LoanPayment < ActiveRecord::Base

  include UUIDHelper

  belongs_to :loan
  validates_presence_of :loan_id
  validates_presence_of :mid_number
  validates_presence_of :payment_amount
  validates_presence_of :payment_date
  validates_presence_of :loan_amount_before_payment
  validates_presence_of :loan_amount_after_payment

  validates_numericality_of :payment_amount
  validates_numericality_of :loan_amount_before_payment
  validates_numericality_of :loan_amount_after_payment

  validates_length_of :remark , maximum: 256

end
