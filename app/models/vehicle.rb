class Vehicle < ActiveRecord::Base

    include BaseConcerns,
            AssociatedFilesConcerns

    validates_presence_of :type_of_vehicle
    validates_presence_of :plate_number
    validates_presence_of :oil
    validates_presence_of :capacity_m3
    validates_presence_of :brand
    validates_presence_of :date_of_implementation

    searchable do

      text :type_of_vehicle
      text :brand
      date :date_of_implementation
      text :plate_number
      text :oil
      float :capacity_m3

    end

end
