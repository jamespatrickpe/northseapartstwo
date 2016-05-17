module GeneralAdministration::AssociatedFilesHelper

  def controller_link(result)
    controller_link = nil
    if result.class == SystemAssociation
      controller_link = general_administration_associated_files_system_associations_path
    elsif result.class == LinkSet
      controller_link = general_administration_associated_files_link_sets_path
    elsif result.class == ImageSet
      controller_link = general_administration_associated_files_image_sets_path
    elsif result.class == FileSet
      controller_link = general_administration_associated_files_file_sets_path
    end
    controller_link
  end

end
