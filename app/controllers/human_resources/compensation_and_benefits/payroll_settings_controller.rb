class HumanResources::CompensationAndBenefits::PayrollSettingsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('payroll_settings','payroll_settings.created_at')
    begin
      @payroll_settings = PayrollSetting.includes(employee: [:actor])
                      .joins(employee: [:actor])
                      .where("actors.name LIKE ? OR " +
                                 "payroll_settings.id LIKE ? OR " +
                                 "payroll_settings.article LIKE ? OR " +
                                 "payroll_settings.applicability LIKE ? OR " +
                                 "payroll_settings.date_of_implementation LIKE ? OR " +
                                 "payroll_settings.remark LIKE ? OR " +
                                 "payroll_settings.created_at LIKE ? OR " +
                                 "payroll_settings.updated_at LIKE ?",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @payroll_settings = Kaminari.paginate_array(@payroll_settings).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_and_benefits/payroll_settings/index'
  end

  def initialize_form
    initialize_form_variables('Payroll Settings',
                              'human_resources/compensation_and_benefits/payroll_settings/payroll_setting_form',
                              'payroll_setting')
    initialize_employee_selection
  end

  def search_suggestions
    generic_employee_name_search_suggestions(PayrollSetting)
  end

  def new
    initialize_form
    @selected_payroll_setting = PayrollSetting.new
    generic_bicolumn_form_with_employee_selection(@selected_payroll_setting)
  end

  def edit
    initialize_form
    @selected_payroll_setting = PayrollSetting.find(params[:id])
    generic_bicolumn_form_with_employee_selection(@selected_payroll_setting)
  end

  def process_payroll_form(payroll_setting)
    begin
      employee = Employee.find(params[:payroll_setting][:employee_id])
      payroll_setting.employee = employee
      payroll_setting.article = params[:payroll_setting][:article]
      payroll_setting.applicability = params[:payroll_setting][:applicability]
      payroll_setting.date_of_implementation = params[:payroll_setting][:date_of_implementation]
      payroll_setting.remark = params[:payroll_setting][:remark]
      payroll_setting.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def delete
    generic_delete_model(PayrollSetting, controller_name)
  end

  def update
    payroll_setting = PayrollSetting.find(params[:payroll_setting][:id])
    flash[:general_flash_notification] = 'Payroll Updated'
    process_payroll_form(payroll_setting)
  end

  def create
    payroll_setting = PayrollSetting.new()
    flash[:general_flash_notification] = 'Payroll Created'
    process_payroll_form(payroll_setting)
  end

end
