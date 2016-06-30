class HumanResources::EmployeeAccountsManagementController < HumanResourcesController

  def index

    @overview_panels = [
        [human_resources_employee_accounts_management_employees_path,'Employees'],
        [human_resources_employee_accounts_management_biodata_path,'Biodata'],
        [human_resources_employee_accounts_management_duty_statuses_path,'Duty Status']
    ]

    @wizard_buttons =
        [
            [human_resources_employee_accounts_management_add_employee_wizard_path(:setup_system_account),'Setup Employee']
        ]

    generic_index_main('Account Management for an Employee')

  end

end
