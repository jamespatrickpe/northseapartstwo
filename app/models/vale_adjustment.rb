class ValeAdjustment < ActiveRecord::Base

  include BaseConcerns,
          Amount,
          Remark

  belongs_to :vale

  validates_length_of :amount, maximum: 64
  validates_length_of :remark , maximum: 256
  validates_presence_of :datetime_of_implementation, maximum: 256

end
