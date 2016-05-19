class Vehicle < ActiveRecord::Base

    include BaseConcerns,
            AssociatedFilesConcerns

    validates_presence_of :type_of_vehicle
    validates_presence_of :plate_number
    validates_presence_of :orcr
    validates_presence_of :capacity_m3

    searchable do

      text :type_of_vehicle
      text :plate_number
      text :orcr
      float :capacity_m3

    end

end
