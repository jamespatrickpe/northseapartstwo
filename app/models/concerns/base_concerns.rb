module BaseConcerns extend ActiveSupport::Concern

  included do

    before_create{
      self.id = UUIDTools::UUID.timestamp_create().to_s.downcase if id.blank?
    }
    self.primary_key = 'id'

    searchable do
      string :id
      time :created_at
      time :updated_at
      text :id, :created_at, :updated_at
      time :created_at, :updated_at
    end

    def polymorphic_searchable_representation(attribute)
      if attribute.class == Actor
        attribute.name
      elsif attribute.class == Branch
        attribute.name
      end
    end

  end

  module ClassMethods


  end




end