class GeneralAdministration::ImportContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :upload_excel
        :show_results

  def show

    case step
      when :upload_excel
      when :show_results
    end
    render_wizard

  end

  def update

    case step
      when :upload_excel
      when :show_results
    end
    render_wizard

  end

end
