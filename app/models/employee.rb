class Employee < ActiveRecord::Base

  include UUIDHelper

  belongs_to :entity
  has_one :status
  has_many :restdays
  has_one :regular_work_period

  validates_presence_of :entity

end
