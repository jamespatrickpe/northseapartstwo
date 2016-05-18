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
      if attribute.class == SystemActor
        attribute.name
      elsif attribute.class == Branch
        attribute.name
      elsif attribute.class == Vehicle
        attribute.plate_number
      end
    end

    def main_representation
      representative_hash = Hash.new()
      main_case = Rails.application.routes.url_helpers

      case self
        when SystemActor
          representative_hash[:attribute] = self.name
          representative_hash[:controller_path] = main_case.general_administration_system_actors_path
        when Branch
          representative_hash[:attribute] = self.name
          representative_hash[:controller_path] = main_case.general_administration_branches_path
        when Vehicle
          representative_hash[:attribute] = self.plate_number
          representative_hash[:controller_path] = main_case.general_administration_vehicles_path
        when Telephone
          representative_hash[:attribute] = self.digits
          representative_hash[:controller_path] = main_case.general_administration_contact_details_telephones_path
        when Address
          representative_hash[:attribute] = self.remark
          representative_hash[:controller_path] = main_case.general_administration_contact_details_addresses_path
        when Digital
          representative_hash[:attribute] = self.url
          representative_hash[:controller_path] = main_case.general_administration_contact_details_digitals_path
        when FileSet
          representative_hash[:attribute] = self.remark
          representative_hash[:controller_path] = main_case.general_administration_associated_files_file_sets_path
        when ImageSet
          representative_hash[:attribute] = self.remark
          representative_hash[:controller_path] = main_case.general_administration_associated_files_image_sets_path
        when LinkSet
          representative_hash[:attribute] = self.url
          representative_hash[:controller_path] = main_case.general_administration_associated_files_link_sets_path
        when SystemAssociation
          representative_hash[:attribute] = (self.model_one.main_representation.to_s + self.model_two.main_representation.to_s)
          representative_hash[:controller_path] = main_case.general_administration_associated_files_system_associations_path
        else
          representative_hash[:attribute] = self.class
          representative_hash[:controller_path] = self.class
      end

      return representative_hash
    end

  end

  module ClassMethods
  end




end