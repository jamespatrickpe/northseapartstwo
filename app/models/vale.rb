class Vale < ActiveRecord::Base

  include BaseConcerns,
          Amount,
          Remark,
          PeriodOfTime

  belongs_to :employee

  validates_presence_of :datetime_of_implementation, maximum: 256
  validates_presence_of :amount_of_deduction, maximum: 16
  validates :approval_status, inclusion: { in: [true, false] }

end
