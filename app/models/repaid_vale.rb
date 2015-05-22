class RepaidVale < ActiveRecord::Base

  include UUIDHelper

  belongs_to :vale
  validates_presence_of :vale
  validates_presence_of :amount
  validates_numericality_of :amount

end
