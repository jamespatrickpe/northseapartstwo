class HumanResources::CompensationAndBenefits::InstitutionalAdjustmentsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('institutional_adjustments','institutional_adjustments.created_at')
    begin
      @base_rates = BaseRate
        .where("actors.name LIKE ? OR " +
                 "institutional_adjustments.id LIKE ? OR " +
                 "institutional_adjustments.name LIKE ? OR " +
                 "institutional_adjustments.description LIKE ? OR " +
                 "institutional_adjustments.logo LIKE ? OR " +
                 "institutional_adjustments.period_of_time LIKE ? OR " +
                 "institutional_adjustments.remark LIKE ? OR " +
                 "institutional_adjustments.start_of_effectivity LIKE ? OR " +
                 "institutional_adjustments.end_of_effectivity LIKE ? OR " +
                 "institutional_adjustments.created_at LIKE ? OR " +
                 "institutional_adjustments.updated_at LIKE ?",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%")
      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @base_rates = Kaminari.paginate_array(@base_rates).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_and_benefits/base_rates/index'
  end

  def search_suggestions
    baseRates = BaseRate.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + baseRates.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_employee_selection
    @selected_base_rate = BaseRate.new
    render 'human_resources/compensation_and_benefits/base_rates/base_rate_form'
  end

  def edit
    initialize_employee_selection
    @selected_base_rate = BaseRate.find(params[:id])
    render 'human_resources/compensation_and_benefits/base_rates/base_rate_form'
  end

  def process_base_rate_form(baseRate)
    begin
      baseRate.employee_id = params[:base_rate][:employee_id]
      employee = Employee.find(params[:base_rate][:employee_id])
      baseRate.employee = employee
      baseRate.signed_type = params[:base_rate][:signed_type]
      baseRate.amount = params[:base_rate][:amount]
      baseRate.period_of_time = params[:base_rate][:period_of_time]
      baseRate.rate_type = params[:base_rate][:rate_type]
      baseRate.remark = params[:base_rate][:remark]
      baseRate.start_of_effectivity = params[:base_rate][:start_of_effectivity]
      baseRate.end_of_effectivity = params[:base_rate][:end_of_effectivity]
      baseRate.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def delete
    baseRateToBeDeleted = BaseRate.find(params[:id])
    baseRateOwner = Employee.find(baseRateToBeDeleted.employee_id)
    flash[:general_flash_notification] = baseRateOwner.actor.name + '\'s base rate of ' + baseRateToBeDeleted.amount.to_s + ' per ' + baseRateToBeDeleted.period_of_time + ' has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    baseRateToBeDeleted.destroy
    redirect_to :action => 'index'
  end

  def update
    baseRate = BaseRate.find(params[:base_rate][:id])
    flash[:general_flash_notification] = 'Base Rate Updated'
    process_base_rate_form(baseRate)
  end

  def create
    baseRate = BaseRate.new()
    flash[:general_flash_notification] = 'Base Rate Created'
    process_base_rate_form(baseRate)
  end

end