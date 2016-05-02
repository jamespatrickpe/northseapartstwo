class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          UrlConcerns

  belongs_to :contact_detail

=begin
  searchable do

    text :contact_detail do
      polymorphic_contact_details(digitable)
    end

    string :digitable do
      polymorphic_contact_details(digitable)
    end

  end
=end

end
