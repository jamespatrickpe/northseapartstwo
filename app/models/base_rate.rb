class BaseRate < ActiveRecord::Base

  include BaseConcerns
  include Remark

  belongs_to :employee

  validates_presence_of :employee
  validates_presence_of :rate_type

  validates_presence_of :employee
  validates_numericality_of :amount

end
