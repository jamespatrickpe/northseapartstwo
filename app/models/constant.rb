class Constant < ActiveRecord::Base

  include UUIDHelper

  validates_length_of :value, maximum: 64
  validates_length_of :name, maximum: 128
  validates_length_of :constant_type, maximum: 64
  validates_length_of :remark, maximum: 256

  validates_presence_of :name
  validates_presence_of :constant_type
  validates_presence_of :value
end
