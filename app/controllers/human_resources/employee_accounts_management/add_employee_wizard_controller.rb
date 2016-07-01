class HumanResources::EmployeeAccountsManagement::AddEmployeeWizardController < HumanResources::EmployeeAccountsManagementController

  include Wicked::Wizard

  steps :setup_system_account,
        :setup_employee,
        :setup_biodata,
        :setup_duty_status,
        :final

  def show

    case step
      when :setup_system_account
        setup_step('Setup System Account',SystemAccount, false)
      when :setup_employee
        setup_step('Setup Employee',Employee, false)
      when :setup_biodata
        setup_step('Setup Biodata',Biodatum, false)
      when :setup_duty_status
        setup_step('Setup Duty Status',DutyStatus, false)
      when :final
    end
    render_wizard

  end

  def update

    case step
      when :setup_system_account
        extracted_id = setup_update_wizard_step(SystemAccount)
      when :setup_employee
        setup_update_wizard_step(Employee)
      when :setup_biodata
        setup_update_wizard_step(Biodatum)
      when :setup_duty_status
        setup_update_wizard_step(DutyStatus)
      when :final
    end
    redirect_setup_update(params,'SystemAccount',extracted_id)
  end

end
