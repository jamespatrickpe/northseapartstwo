class HumanResources::CompensationAndBenefits::LumpAdjustmentsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('lump_adjustments','lump_adjustments.created_at')
    begin
      @lump_adjustments = LumpAdjustment
      .includes(employee: [:actor])
      .joins(employees: [:actor])
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
    render 'human_resources/compensation_benefits/lump_adjustments'
  end

  def search_suggestions
    adjustments = LumpAdjustment.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + adjustments.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete_lump_adjustment
    lumpAdjustmentToBeDeleted = LumpAdjustment.find(params[:lump_adjustment_id])
    lumpAdjustmentOwner = Employee.find(lumpAdjustmentToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Lump adjustment for employees ' + lumpAdjustmentOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    lumpAdjustmentToBeDeleted.destroy
    redirect_to :action => "lump_adjustments"
  end

  def new_lump_adjustment
    initialize_employee_selection
    @selected_lump_adjustment = LumpAdjustment.new
    render 'human_resources/compensation_benefits/lump_adjustment_form'
  end

  def edit_lump_adjustment
    initialize_employee_selection
    @selected_lump_adjustment = LumpAdjustment.find(params[:lump_adjustment_id])
    render 'human_resources/compensation_benefits/lump_adjustment_form'
  end

  def process_lump_adjustment_form
    begin
      if( params[:lump_adjustment][:id].present? )
        lumpAdjustment = LumpAdjustment.find(params[:lump_adjustment][:id])
      else
        lumpAdjustment = LumpAdjustment.new()
      end
      lumpAdjustment.id = params[:lump_adjustment][:id]
      lumpAdjustment.amount = params[:lump_adjustment][:amount]
      lumpAdjustment.employee_id = params[:lump_adjustment][:employee_id]
      lumpAdjustment.signed_type = params[:lump_adjustment][:signed_type]
      lumpAdjustment.remark = params[:lump_adjustment][:remark]
      lumpAdjustment.date_of_effectivity = params[:lump_adjustment][:date_of_effectivity]
      lumpAdjustment.save!
      flash[:general_flash_notification] = 'Lump Adjustment Added'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'lump_adjustments'
  end

end
