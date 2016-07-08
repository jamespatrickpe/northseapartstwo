class HumanResources::Settings::ConstantsController < HumanResources::SettingsController

  def index

    begin

      query = generic_index_aggregated_queries(controller_name,'updated_at')
      search = Sunspot.search( Constant ) do
        fulltext query[:search_field]
        keywords query[:search_field]
        order_by query[:order_parameter].to_sym,
                 query[:order_orientation].parameterize.underscore.to_sym
        paginate :page => params[:page],
                 :per_page => query[:current_limit]
      end
      @result_set = search.results
    rescue => ex
      index_error(ex, nil)
    end

    generic_index_main('Important Variables for the Human Resource Module')

  end

  def search_suggestions
    generic_index_search_suggestions(Constant)
  end

  def new
    set_new_edit(Constant)
  end

  def edit
    set_new_edit(Constant)
  end

  def show
    edit
  end

  def delete
    generic_delete(Constant)
  end

  def process_form(my_constant, current_params, wizard_mode = nil)
    begin
      my_constant[:remark] = current_params[:remark]
      my_constant[:name] = current_params[:name]
      my_constant[:date_of_implementation] = current_params[:date_of_implementation]
      my_constant[:value] = current_params[:value]
      my_constant.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Constant.new(), params[controller_path])
  end

  def update
    process_form(Constant.find(params[controller_path][:id]), params[controller_path])
  end

end
