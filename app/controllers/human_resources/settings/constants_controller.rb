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

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
