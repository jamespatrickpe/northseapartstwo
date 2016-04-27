class Address < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          ContactDetailsConcerns


  belongs_to :addressable, polymorphic: true

  searchable do
    string :longitude
    string :latitude
    text :latitude
    text :longitude

    text :addressable do
      polymorphic_contact_details(addressable)
    end

    string :addressable do
      polymorphic_contact_details(addressable)
    end

  end

  validates_numericality_of :longitude
  validates_numericality_of :latitude

end
