class Branch < ActiveRecord::Base

  include UUIDHelper

  has_many :employee
end
