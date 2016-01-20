class HumanResources::CompensationAndBenefits::PayrollsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('payrolls','payrolls.created_at')
    begin
      @payrolls = Payroll.includes(employee: [:actor])
                      .joins(employee: [:actor])
                      .where("actors.name LIKE ? OR " +
                                 "payrolls.id LIKE ? OR " +
                                 "payrolls.article LIKE ? OR " +
                                 "payrolls.applicability LIKE ? OR " +
                                 "payrolls.date_of_effectivity LIKE ? OR " +
                                 "payrolls.remark LIKE ? OR " +
                                 "payrolls.created_at LIKE ? OR " +
                                 "payrolls.updated_at LIKE ?",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @payrolls = Kaminari.paginate_array(@payrolls).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_and_benefits/payrolls/index'
  end

  def search_suggestions
    payrolls = Payroll.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + payrolls.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_employee_selection
    @selected_payroll = Payroll.new
    render 'human_resources/compensation_and_benefits/payrolls/payroll_form'
  end

  def edit
    initialize_employee_selection
    @selected_payroll = Payroll.find(params[:id])
    render 'human_resources/compensation_and_benefits/payrolls/payroll_form'
  end

  def process_base_rate_form(payroll)
    begin
      employee = Employee.find(params[:payroll][:employee_id])
      payroll.employee = employee
      payroll.article = params[:payroll][:article]
      payroll.applicability = params[:payroll][:applicability]
      payroll.date_of_effectivity = params[:payroll][:date_of_effectivity]
      payroll.remark = params[:payroll][:remark]
      payroll.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def delete
    payroll_to_be_deleted = Payroll.find(params[:id])
    employee = Employee.find(payroll_to_be_deleted.employee_id)
    flash[:general_flash_notification] = employee.actor.name + '\'s Payroll Settings of ' + payroll_to_be_deleted + 'has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    payroll_to_be_deleted.destroy
    redirect_to :action => 'index'
  end

  def update
    payroll = Payroll.find(params[:base_rate][:id])
    flash[:general_flash_notification] = 'Payroll Updated'
    process_base_rate_form(payroll)
  end

  def create
    payroll = Payroll.new()
    flash[:general_flash_notification] = 'Payroll Created'
    process_base_rate_form(payroll)
  end

  def show

  end

  def branch

  end

end
