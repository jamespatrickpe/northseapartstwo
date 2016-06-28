class Employee < ActiveRecord::Base

  include BaseConcerns, RemarkConcerns

  belongs_to :system_account
  has_many :duty_status
  has_many :rest_day
  has_many :attendances
  has_one :regular_work_period

  searchable do

    text :system_account_names do |employee|
      employee.system_account.name
    end

  end

  validates_presence_of :system_account

end
