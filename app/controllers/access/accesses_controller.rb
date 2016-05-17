class Access::AccessesController < AccessController

  def index
    query = generic_index_aggregated_queries('accesses','accesses.created_at')
    begin
      @accesses = Access
                      .where("accesses.username LIKE ? OR " +
                                 "accesses.email LIKE ? ",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @accesses = Kaminari.paginate_array(@accesses).page(params[:page]).per(query[:current_limit])
    rescue => ex
      puts ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/access/accesses/index'
  end

  def initialize_form
    initialize_form_variables('ACCESS',
                              'access/accesses/access_form',
                              'access')
  end

  def search_suggestions
    accesses = Access
                   .where("accesses.username LIKE ?","%#{params[:query]}%")
                   .pluck("accesses.username")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + accesses.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_access = Access.new
    @actors = Actor.all().order('name ASC')
    generic_form_main(@selected_access)
  end

  def edit
    initialize_form
    @selected_access = Access.find(params[:id])
    @actors = Actor.all().order('name ASC')
    generic_form_main(@selected_access)
  end

  def delete
    generic_delete_model(Access,controller_name)
  end

  def process_access_form(myAccess)
    begin
      myAccess[:system_actor_id] = params[:access][:system_actor_id]
      myAccess[:username] = params[:access][:username]
      myAccess[:password_digest] = params[:access][:password_digest]
      myAccess[:email] = params[:access][:email]
      myAccess[:verification] = params[:access][:verification]
      myAccess[:hash_link] = create_unique_hash_link
      myAccess.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myAccess = Access.new()
    flash[:general_flash_notification] = 'Access Created!'
    process_access_form(myAccess)
  end

  def update
    myAccess = Access.find(params[:access][:id])
    flash[:general_flash_notification] = 'Access Updated: ' + params[:access][:id]
    process_access_form(myAccess)
  end

end