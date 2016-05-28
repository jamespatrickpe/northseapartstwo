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
          representative_hash[:controller_class] = GeneralAdministration::SystemActorsController
        when Branch
          representative_hash[:attribute] = self.name
          representative_hash[:controller_path] = main_case.general_administration_branches_path
          representative_hash[:controller_class] = GeneralAdministration::BranchesController
        when Vehicle
          representative_hash[:attribute] = self.plate_number
          representative_hash[:controller_path] = main_case.general_administration_vehicles_path
          representative_hash[:controller_class] = GeneralAdministration::VehiclesController
        when Telephone
          representative_hash[:attribute] = self.digits
          representative_hash[:controller_path] = main_case.general_administration_contact_details_telephones_path
          representative_hash[:controller_class] = GeneralAdministration::ContactDetails::TelephonesController
          representative_hash[:polymorphic_attribute] = 'telephonable'
        when Address
          representative_hash[:attribute] = self.remark
          representative_hash[:controller_path] = main_case.general_administration_contact_details_addresses_path
          representative_hash[:controller_class] = GeneralAdministration::ContactDetails::AddressesController
          representative_hash[:polymorphic_attribute] = 'addressable'
        when Digital
          representative_hash[:attribute] = self.url
          representative_hash[:controller_path] = main_case.general_administration_contact_details_digitals_path
          representative_hash[:controller_class] = GeneralAdministration::ContactDetails::DigitalsController
          representative_hash[:polymorphic_attribute] = 'digitable'
        when FileSet
          representative_hash[:attribute] = self.remark
          representative_hash[:controller_path] = main_case.general_administration_associated_files_file_sets_path
          representative_hash[:controller_class] = GeneralAdministration::AssociatedFiles::FileSetsController
          representative_hash[:polymorphic_attribute] = 'filesetable'
        when ImageSet
          representative_hash[:attribute] = self.remark
          representative_hash[:controller_path] = main_case.general_administration_associated_files_image_sets_path
          representative_hash[:controller_class] = GeneralAdministration::AssociatedFiles::ImageSetsController
          representative_hash[:polymorphic_attribute] = 'imagesetable'
        when LinkSet
          representative_hash[:attribute] = self.url
          representative_hash[:controller_path] = main_case.general_administration_associated_files_link_sets_path
          representative_hash[:controller_class] = GeneralAdministration::AssociatedFiles::LinkSetsController
          representative_hash[:polymorphic_attribute] = 'linksetable'
        when SystemAssociation
          representative_hash[:attribute] = (self.remark)
          representative_hash[:controller_path] = main_case.general_administration_associated_files_system_associations_path
          representative_hash[:controller_class] = GeneralAdministration::AssociatedFiles::SystemAssociationsController
          representative_hash[:polymorphic_attribute] = 'model_one'
      end

      return representative_hash
    end

  end

  module ClassMethods
  end




end