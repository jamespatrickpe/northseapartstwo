module ContactDetailsConcerns extend ActiveSupport::Concern

  included do

    def polymorphic_contact_details(attribute)
      if attribute.class == Actor
        attribute.name
      elsif attribute.class == Branch
        attribute.name
      end
    end

  end
end