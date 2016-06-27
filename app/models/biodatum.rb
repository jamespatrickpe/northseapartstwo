class Biodatum < ActiveRecord::Base

  include BaseConcerns

  belongs_to :system_account
  validates_presence_of :system_account

end
