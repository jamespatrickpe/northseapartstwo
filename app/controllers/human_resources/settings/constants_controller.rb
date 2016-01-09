class HumanResources::Settings::ConstantsController < HumanResources::SettingsController

  def index
    query = generic_table_aggregated_queries('constants','constants.created_at')
    begin
      @constants = Constant
                       .where("constants.id LIKE ? OR " +
                                  "constants.value LIKE ? OR " +
                                  "constants.name LIKE ? OR " +
                                  "constants.constant_type LIKE ? OR " +
                                  "constants.remark LIKE ? OR " +
                                  "constants.created_at LIKE ? OR " +
                                  "constants.updated_at LIKE ?",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%")
                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @constants = Kaminari.paginate_array(@constants).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/settings/constants/index'
  end

  def new
    @selected_constant = Constant.new
    render 'human_resources/settings/constants/constant_form'
  end

  def edit
    @selected_constant = Constant.find(params[:id])
    render 'human_resources/settings/constants/constant_form'
  end


  def delete
    constant_to_be_deleted = Constant.find(params[:id])
    flash[:general_flash_notification] = 'Constant / System param ' + constant_to_be_deleted.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    constant_to_be_deleted.destroy
    redirect_to :action => "index"
  end

  def process_constant_form(currentConstant)
    begin
      currentConstant[:constant_type] = params[:constant][:constant_type]
      currentConstant[:name] = params[:constant][:name]
      currentConstant[:value] = params[:constant][:value]
      currentConstant[:remark] = params[:constant][:remark]
      currentConstant.save!
      flash[:general_flash_notification] = 'Constant / System param ' + currentConstant[:name] + ' has been added.'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end


  def search_suggestions_constants
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
