class Vehicle < ActiveRecord::Base

    include BaseConcerns,
            AssociatedFilesConcerns

    validates_presence_of :date_of_implementation
    validates_presence_of :type_of_vehicle
    validates_presence_of :plate_number
    validates_presence_of :orcr

    validates_presence_of :capacity_m3
    validates_numericality_of :capacity_m3

    searchable do

      string :type_of_vehicle
      string :plate_number
      string :orcr
      float :capacity_m3
      time :date_of_implementation

    end

end
