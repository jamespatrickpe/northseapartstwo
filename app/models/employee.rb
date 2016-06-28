class Employee < ActiveRecord::Base

  include BaseConcerns, RemarkConcerns

  belongs_to :system_account
  has_many :duty_status
  has_many :restdays
  has_many :attendances
  has_one :regular_work_period

  searchable do

    text :system_account_name do
      system_account.name
    end

  end

  def system_account_name(name)
    SystemAccount.find_by_name(name)
  end

  validates_presence_of :system_account

end
