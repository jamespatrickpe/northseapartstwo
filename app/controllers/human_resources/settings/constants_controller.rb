class HumanResources::Settings::ConstantsController < HumanResources::SettingsController

  def index
    query = generic_table_aggregated_queries('constants','constants.created_at')
    begin
      @constants = Constant
                       .where("(constants.id LIKE ? OR " +
                                  "constants.value LIKE ? OR " +
                                  "constants.name LIKE ? OR " +
                                  "constants.constant_type LIKE ? OR " +
                                  "constants.remark LIKE ? OR " +
                                  "constants.created_at LIKE ? OR " +
                                  "constants.updated_at LIKE ?) AND ( constants.constant_type LIKE ? )",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "human_resources.#{query[:search_field]}%")
                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @constants = Kaminari.paginate_array(@constants).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'shared/constants/index'
  end

  def initialize_form
    initialize_form_variables('SYSTEM CONSTANT',
                              'shared/constants/constant_form',
                              'constant')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_constant = Constant.new
    generic_form_main(@selected_constant)
  end

  def edit
    initialize_form
    @selected_constant = Constant.find(params[:id])
    generic_form_main(@selected_constant)
  end


  def delete
    generic_delete_model(Constant, controller_name)
  end

  def process_constant_form(currentConstant)
    begin
      currentConstant[:constant_type] = "human_resources." + params[:constant][:constant_type]
      currentConstant[:name] = params[:constant][:name]
      currentConstant[:value] = params[:constant][:value]
      currentConstant[:date_of_implementation] = params[:constant][:date_of_implementation]
      currentConstant[:remark] = params[:constant][:remark]
      currentConstant.save!
      flash[:general_flash_notification] = 'Constant / System param ' + currentConstant[:name] + ' has been added and will be effective on ' + currentConstant[:date_of_implementation].to_s
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end


  def search_suggestions
    constants = Constant
                    .where("constants.name LIKE ?","%#{params[:query]}%")
                    .pluck("constants.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + constants.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def create
    currentConstant = Constant.new()
    flash[:general_flash_notification] = 'System parameter / Constant Created!'
    process_constant_form(currentConstant)
  end

  def update
    currentConstant = Constant.find(params[:constant][:id])
    flash[:general_flash_notification] = 'Constant Updated: ' + params[:constant][:id]
    process_constant_form(currentConstant)
  end

end
