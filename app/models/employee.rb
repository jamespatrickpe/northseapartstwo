class Employee < ActiveRecord::Base

  include UUIDHelper

  belongs_to :actor
  has_one :duty
  has_many :restdays
  has_one :regular_work_period

  validates_presence_of :actor

end
