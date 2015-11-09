class RepaidPaymentsFromEmployee < ActiveRecord::Base

  include UUIDHelper

  belongs_to :advanced_payments_to_employee
  validates_presence_of :advanced_payments_to_employee
  validates_presence_of :amount
  validates_numericality_of :amount

end
