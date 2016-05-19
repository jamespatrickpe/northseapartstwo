class HumanResources::CompensationAndBenefits::InstitutionalAdjustmentsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('institutional_adjustments','institutional_adjustments.created_at')
    begin
      @institutional_adjustments = InstitutionalAdjustment
                                       .where("institutional_adjustments.id LIKE ? OR " +
                                                  "institutional_adjustments.institution LIKE ? OR " +
                                                  "institutional_adjustments.contribution_type LIKE ? OR " +
                                                  "institutional_adjustments.start_range LIKE ? OR " +
                                                  "institutional_adjustments.end_range LIKE ? OR " +
                                                  "institutional_adjustments.employer_contribution LIKE ? OR " +
                                                  "institutional_adjustments.employee_contribution LIKE ? OR " +
                                                  "institutional_adjustments.period_of_time LIKE ? OR " +
                                                  "institutional_adjustments.description LIKE ? OR " +
                                                  "institutional_adjustments.date_of_effectivity LIKE ? OR " +
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
                                              "%#{query[:search_field]}%",
                                              "%#{query[:search_field]}%")
                                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @institutional_adjustments = Kaminari.paginate_array(@institutional_adjustments).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/compensation_and_benefits/institutional_adjustments/index'
  end

  def search_suggestions
    institutional_adjustments = InstitutionalAdjustment.pluck("institutional_adjustments.contribution_type")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + institutional_adjustments.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end


  def initialize_form
    initialize_form_variables('INSTITUTIONAL ADJUSTMENTS',
                              'Logs all institutional adjustments within the system',
                              'human_resources/compensation_and_benefits/institutional_adjustments/institutional_adjustment_form',
                              'institutional_adjustment')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_institutional_adjustment = InstitutionalAdjustment.new
    generic_singlecolumn_form(@selected_institutional_adjustment)
  end

  def edit
    initialize_form
    @selected_institutional_adjustment = InstitutionalAdjustment.find(params[:id])
    generic_singlecolumn_form(@selected_institutional_adjustment)
  end

  def process_institutional_adjustment_form(institutional_adjustment)
    begin
      institutional_adjustment.institution = params[:institutional_adjustment][:institution]
      institutional_adjustment.contribution_type = params[:institutional_adjustment][:contribution_type]
      institutional_adjustment.start_range = params[:institutional_adjustment][:start_range]
      institutional_adjustment.end_range = params[:institutional_adjustment][:end_range]
      institutional_adjustment.employer_contribution = params[:institutional_adjustment][:employer_contribution]
      institutional_adjustment.employee_contribution = params[:institutional_adjustment][:employee_contribution]
      institutional_adjustment.period_of_time = params[:institutional_adjustment][:period_of_time]
      institutional_adjustment.description = params[:institutional_adjustment][:description]
      institutional_adjustment.date_of_effectivity = params[:institutional_adjustment][:date_of_effectivity]
      institutional_adjustment.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts '----'
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def delete
    generic_delete_model(InstitutionalAdjustment, controller_name)
  end

  def update
    institutional_adjustment = InstitutionalAdjustment.find(params[:institutional_adjustment][:id])
    flash[:general_flash_notification] = 'Institutional Adjustment Updated'
    process_institutional_adjustment_form(institutional_adjustment)
  end

  def create
    institutional_adjustment = InstitutionalAdjustment.new()
    flash[:general_flash_notification] = 'Institutional Adjustment Created'
    process_institutional_adjustment_form(institutional_adjustment)
  end

end