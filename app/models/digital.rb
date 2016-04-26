class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          UrlConcerns,
          ContactDetailsConcerns

  belongs_to :digitable, polymorphic: true

  searchable do

    text :digitable do
      polymorphic_contact_details(digitable)
    end

    string :digitable do
      polymorphic_contact_details(digitable)
    end

  end

end
