class LumpAdjustment < ActiveRecord::Base

  include BaseConcerns,
          Remark,
          Amount

  belongs_to :employee

  validates_presence_of :datetime_of_implementation
end