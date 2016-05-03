class Address < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :contact_detail

  searchable do
    string :longitude
    string :latitude
    text :latitude
    text :longitude
=begin

    text :addressable do
      polymorphic_contact_details(addressable)
    end

    string :addressable do
      polymorphic_contact_details(addressable)
    end
=end

  end

  validates_numericality_of :longitude
  validates_numericality_of :latitude

end
