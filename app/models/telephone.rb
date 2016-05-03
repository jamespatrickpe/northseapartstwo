class Telephone < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :contact_detail

=begin

  searchable do

    text :telephonable do
      polymorphic_contact_details(telephonable)
    end

    string :telephonable do
      polymorphic_contact_details(telephonable)
    end

  end
=end

  validates_length_of :digits , maximum: 32, message: "digits must be less than 32 characters"

end
