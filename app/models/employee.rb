class Employee < ActiveRecord::Base



  belongs_to :actor
  belongs_to :branch
  has_many :duty_status
  has_many :restdays
  has_many :attendances
  has_one :regular_work_period


  validates_presence_of :actor
  # validates_presence_of :branches

end
