class Employee < ActiveRecord::Base

  include UUIDHelper

  belongs_to :actor
  belongs_to :branch
  has_many :duty_status
  has_many :restdays
  has_one :regular_work_period


  validates_presence_of :actor
  validates_presence_of :branch

end
