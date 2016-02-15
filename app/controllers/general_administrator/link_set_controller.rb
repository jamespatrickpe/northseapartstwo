class GeneralAdministrator::LinkSetController < GeneralAdministratorController


  def index
    query = generic_table_aggregated_queries('link_sets','link_sets.created_at')
    begin
      @link_sets = LinkSet
                        .where("link_sets.url LIKE ? OR " +
                                   "link_sets.label LIKE ?",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%")
                        .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @link_sets = Kaminari.paginate_array(@link_sets).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/general_administrator/link_set/index'
  end


  def initialize_form
    initialize_form_variables('SYSTEM LINK SETS',
                              'Create a new link set within the system',
                              'general_administrator/link_set/link_set_form',
                              'link_set')
    initialize_employee_selection
  end

  def search_suggestions
    link_set = LinkSet
                    .where("link_sets.url LIKE ?","%#{params[:query]}%")
                    .pluck("link_sets.url")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + link_set.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_link_set = LinkSet.new
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_singlecolumn_form(@selected_link_set)
  end

  def edit
    initialize_form
    @selected_link_set = LinkSet.find(params[:id])
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_singlecolumn_form(@selected_link_set)
  end

  def delete
    generic_delete_model(LinkSet,controller_name)
  end

  def process_link_set_form(myLinkSet)
    begin
      myLinkSet[:url] = params[:link_set][:url]
      myLinkSet[:label] = params[:link_set][:label]
      myLinkSet[:rel_link_set_id] = params[:link_set][:rel_link_set_id]
      myLinkSet[:rel_link_set_type] = params[:link_set][:rel_link_set_type]
      myLinkSet.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myLinkSet = LinkSet.new()
    flash[:general_flash_notification] = 'Link Set Created!'
    process_link_set_form(myLinkSet)
  end

  def update
    myLinkSet = LinkSet.find(params[:link_set][:id])
    flash[:general_flash_notification] = 'Link Set Updated: ' + params[:link_set][:id]
    process_link_set_form(myLinkSet)
  end

end