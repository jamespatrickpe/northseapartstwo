class Employee < ActiveRecord::Base

  include BaseConcerns

  belongs_to :system_actor
  belongs_to :branch
  has_many :duty_status
  has_many :restdays
  has_many :attendances
  has_one :regular_work_period

  validates_presence_of :system_actor

end
