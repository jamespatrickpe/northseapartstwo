module BaseConcerns extend ActiveSupport::Concern

  included do

    before_create{
      self.id = UUIDTools::UUID.timestamp_create().to_s.downcase if id.blank?
    }
    self.primary_key = 'id'

    searchable do
      string :id
      string :sortable_class
      string :main_representation
      time :created_at
      time :updated_at
      text :id, :created_at, :updated_at
      time :created_at, :updated_at
    end

    def sortable_class
      self.class
    end

    def polymorphic_searchable_representation(attribute)
      if attribute.class == Actor
        attribute.name
      elsif attribute.class == Branch
        attribute.name
      elsif attribute.class == Vehicle
        attribute.plate_number
      end
    end

    def main_representation
      if self.class == Actor
        self.name
      elsif self.class == Branch
        self.name
      elsif self.class == Vehicle
        self.plate_number
      elsif self.class == FileSet
        self.file
      end
    end

  end

  module ClassMethods
  end




end