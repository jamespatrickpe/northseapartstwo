class HumanResources::CompensationAndBenefits::ValeAdjustmentsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('vale_adjustments','vale_adjustments.created_at')
    begin
      @vale_adjustments = ::ValeAdjustment
                   .includes(vale: [employee: [:actor]])
                   .joins(vale: [employee: [:actor]])
                   .where("actors.name LIKE ? OR " +
                              "vale_adjustments.id LIKE ? OR " +
                              "vale_adjustments.amount LIKE ? OR " +
                              "vale_adjustments.signed_type LIKE ? OR " +
                              "vale_adjustments.remark LIKE ? OR " +
                              "vale_adjustments.vale_id LIKE ? OR " +
                              "vale_adjustments.date_of_effectivity LIKE ? OR " +
                              "vale_adjustments.created_at LIKE ? OR " +
                              "vale_adjustments.updated_at LIKE ?",
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
      @vale_adjustments = Kaminari.paginate_array(@vale_adjustments).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_and_benefits/vale_adjustments/index'
  end

  def initialize_form
    initialize_form_variables('VALE ADJUSTMENTS',
                              'Set the Status of an Advanced Payment',
                              'human_resources/compensation_and_benefits/vale_adjustments/vale_adjustments_form',
                              'vale_adjustment')
    initialize_employee_selection
  end

  def search_suggestions
    adjustments = ValeAdjustment.includes(vale: [employee: [:actor]]).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + adjustments.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete
    generic_delete_model(ValeAdjustment, controller_name)
  end

  def new
    initialize_form
    @selected_vale_adjustment = ValeAdjustment.new
    @vales = Vale.includes(employee: [:actor]).joins(employee: [:actor])
    @parent_vale_id = params[:parent_vale_id]
    generic_bicolumn_form_with_employee_selection(@selected_vale_adjustment)
  end

  def edit
    initialize_form
    @selected_vale_adjustment = ValeAdjustment.find(params[:id])
    @vales = Vale.includes(employee: [:actor]).joins(employee: [:actor])
    @parent_vale_id = params[:parent_vale_id]
    generic_bicolumn_form_with_employee_selection(@selected_vale_adjustment)
  end

  def process_vale_adjustment_form(vale_adjustment)
    begin
      vale_adjustment.id = params[:vale_adjustment][:id]
      vale_adjustment.amount = params[:vale_adjustment][:amount]
      vale_adjustment.signed_type = params[:vale_adjustment][:signed_type]
      vale_adjustment.vale_id = params[:vale_adjustment][:vale_id]
      vale_adjustment.remark = params[:vale_adjustment][:remark]
      vale_adjustment.date_of_effectivity = params[:vale_adjustment][:date_of_effectivity]
      vale_adjustment.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def create
    vale_adjustment = ValeAdjustment.new()
    flash[:general_flash_notification] = 'Vale Added!'
    process_vale_adjustment_form(vale_adjustment)
  end

  def update
    vale_adjustment = ValeAdjustment.find(params[:vale_adjustment][:id])
    flash[:general_flash_notification] = 'Vale Updated!'
    process_vale_adjustment_form(vale_adjustment)
  end

end
