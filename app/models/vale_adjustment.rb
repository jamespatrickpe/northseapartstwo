class ValeAdjustment < ActiveRecord::Base

  include BaseConcerns,
          AmountValidations,
          RemarkValidations

  belongs_to :vale
  validates_length_of :amount, maximum: 64
  validates_length_of :remark , maximum: 256
  validates_presence_of :date_of_implementation, maximum: 256
  validates :signed_type, inclusion: { in: [true, false] }
end
