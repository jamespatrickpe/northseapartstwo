class Leave < ActiveRecord::Base

  include BaseConcerns

  belongs_to :employee

  validates_presence_of :type_of_leave,
                        :start_of_effectivity,
                        :end_of_effectivity

end
