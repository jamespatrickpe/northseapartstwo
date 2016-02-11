class HumanResources::CompensationAndBenefits::LumpAdjustmentsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('lump_adjustments','lump_adjustments.created_at')
    begin
      @lump_adjustments = LumpAdjustment
      .includes(employee: [:actor])
      .joins(employee: [:actor])
      .where("actors.name LIKE ? OR " +
                 "lump_adjustments.id LIKE ? OR " +
                 "lump_adjustments.amount LIKE ? OR " +
                 "lump_adjustments.signed_type LIKE ? OR " +
                 "lump_adjustments.remark LIKE ? OR " +
                 "lump_adjustments.date_of_effectivity LIKE ? OR " +
                 "lump_adjustments.created_at LIKE ? OR " +
                 "lump_adjustments.updated_at LIKE ?",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%")
      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @lump_adjustments = Kaminari.paginate_array(@lump_adjustments).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_and_benefits/lump_adjustments/index'
  end

  def initialize_form
    initialize_form_variables('LUMP ADJUSTMENTS',
                              'Log a lump adjustment for an employee',
                              'human_resources/compensation_and_benefits/lump_adjustments/lump_adjustment_form',
                              'lump_adjustment')
    initialize_employee_selection
  end

  def search_suggestions
    adjustments = LumpAdjustment.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + adjustments.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete
    generic_delete_model(LumpAdjustment, controller_name)
  end

  def new
    initialize_form
    @selected_lump_adjustment = LumpAdjustment.new
    generic_bicolumn_form_with_employee_selection(@selected_lump_adjustment)
  end

  def edit
    initialize_form
    @selected_lump_adjustment = LumpAdjustment.find(params[:id])
    generic_bicolumn_form_with_employee_selection(@selected_lump_adjustment)
  end

  def process_lump_adjustment_form(lumpAdjustment)
    begin
      lumpAdjustment.id = params[:lump_adjustment][:id]
      lumpAdjustment.amount = params[:lump_adjustment][:amount]
      lumpAdjustment.employee_id = params[:lump_adjustment][:employee_id]
      lumpAdjustment.signed_type = params[:lump_adjustment][:signed_type]
      lumpAdjustment.remark = params[:lump_adjustment][:remark]
      lumpAdjustment.date_of_effectivity = params[:lump_adjustment][:date_of_effectivity]
      lumpAdjustment.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def create
    lumpAdjustment = LumpAdjustment.new()
    process_lump_adjustment_form(lumpAdjustment)
    flash[:general_flash_notification] = 'Lump Adjustment Added!'
  end

  def update
    lumpAdjustment = LumpAdjustment.find(params[:lump_adjustment][:id])
    process_lump_adjustment_form(lumpAdjustment)
    flash[:general_flash_notification] = 'Lump Adjustment Updated!'
  end

end
