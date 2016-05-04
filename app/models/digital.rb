class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          UrlConcerns

  belongs_to :digitable, polymorphic: true

  searchable do

    text :digitable do
      polymorphic_searchable_representation(digitable)
    end

    string :digitable do
      polymorphic_searchable_representation(digitable)
    end

  end

end
