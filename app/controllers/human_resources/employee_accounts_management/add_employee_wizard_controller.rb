class HumanResources::EmployeeAccountsManagement::AddEmployeeWizardController < HumanResources::EmployeeAccountsManagementController

  include Wicked::Wizard

  steps :setup_employee,
        :setup_biodata,
        :setup_duty_status,
        :final

  def show

    case step
      when :setup_employee
        setup_step('Setup Employee',Employee)
      when :setup_biodata
        setup_step('Setup Biodata',Biodatum)
      when :setup_duty_status
        setup_step('Setup Duty Status',DutyStatus)
      when :final
    end
    render_wizard

  end

  def update

    case step
      when :setup_employee
        extracted_id = setup_update_wizard_step(Employee)
      when :setup_biodata
        setup_update_wizard_step(Biodatum)
      when :setup_duty_status
        setup_update_wizard_step(DutyStatus)
      when :final
    end

    redirect_setup_update(params,'Employee',extracted_id)


  end

end
