class Vehicle < ActiveRecord::Base

    include BaseConcerns,
            AssociatedFilesConcerns

    validates_presence_of :type_of_vehicle, :plate_number, :oil, :capacity_m3, :brand, :date_of_implementation

    searchable do

      text :type_of_vehicle
      text :brand
      date :date_of_implementation
      text :plate_number
      text :oil
      float :capacity_m3
      float :load_kg

    end

end
