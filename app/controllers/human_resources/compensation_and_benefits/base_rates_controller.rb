class HumanResources::CompensationAndBenefits::BaseRatesController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('base_rates','base_rates.created_at')
    begin
      @base_rates = BaseRate.includes(employee: [:actor])
                        .joins(employee: [:actor])
                        .where("actors.name LIKE ? OR " +
                                   "base_rates.id LIKE ? OR " +
                                   "base_rates.signed_type LIKE ? OR " +
                                   "base_rates.signed_type LIKE ? OR " +
                                   "base_rates.amount LIKE ? OR " +
                                   "base_rates.period_of_time LIKE ? OR " +
                                   "base_rates.remark LIKE ? OR " +
                                   "base_rates.start_of_effectivity LIKE ? OR " +
                                   "base_rates.end_of_effectivity LIKE ? OR " +
                                   "base_rates.created_at LIKE ? OR " +
                                   "base_rates.updated_at LIKE ?",
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

  def initialize_form
    initialize_form_variables('BASE RATE FORM',
                              'Set the Base Rate for an Employee',
                              'human_resources/compensation_and_benefits/base_rates/base_rate_form',
                              'base_rate')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_base_rate = BaseRate.new
    generic_bicolumn_form_with_employee_selection(@selected_base_rate)
  end

  def edit
    initialize_form
    @selected_base_rate = BaseRate.find(params[:id])
    generic_bicolumn_form_with_employee_selection(@selected_base_rate)
  end

  def search_suggestions
    generic_employee_name_search_suggestions(BaseRate)
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
    generic_delete_model(BaseRate, controller_name)
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
