class PayrollSetting < ActiveRecord::Base

  include BaseConcerns,
          Remark,
          Employee

  validates_presence_of :datetime_of_implementation

  validates :SSS_status, inclusion: { in: [true, false] }
  validates :PHILHEALTH_status, inclusion: { in: [true, false] }
  validates :PAGIBIG_status, inclusion: { in: [true, false] }
  validates :BIR_status, inclusion: { in: [true, false] }

end
