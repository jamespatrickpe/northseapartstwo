class Biodatum < ActiveRecord::Base

  include BaseConcerns

  belongs_to :system_actor
  validates_presence_of :system_actor

end
