class HumanResources::CompensationAndBenefits::ValesController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('vales','vales.created_at')
    begin
      @vales = ::Vale
                   .includes(employee: [:actor])
                   .joins(employee: [:actor])
                              .where("actors.name LIKE ? OR " +
                                         "vales.id LIKE ? OR " +
                                         "vales.amount LIKE ? OR " +
                                         "vales.amount_of_deduction LIKE ? OR " +
                                         "vales.period_of_deduction LIKE ? OR " +
                                         "vales.remark LIKE ? OR " +
                                         "vales.date_of_effectivity LIKE ? OR " +
                                         "vales.created_at LIKE ? OR " +
                                         "vales.updated_at LIKE ?",
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
      @vales = Kaminari.paginate_array(@vales).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/compensation_and_benefits/vales/index'
  end

  def search_suggestions
    adjustments = LumpAdjustment.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + adjustments.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete
    lumpAdjustmentToBeDeleted = LumpAdjustment.find(params[:id])
    lumpAdjustmentOwner = Employee.find(lumpAdjustmentToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Lump adjustment for employees ' + lumpAdjustmentOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    lumpAdjustmentToBeDeleted.destroy
    redirect_to :action => 'index'
  end

  def new
    initialize_employee_selection
    @selected_lump_adjustment = LumpAdjustment.new
    render 'human_resources/compensation_and_benefits/vales/vales_form'
  end

  def edit
    initialize_employee_selection
    @selected_lump_adjustment = LumpAdjustment.find(params[:id])
    render 'human_resources/compensation_and_benefits/vales/vales_form'
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
