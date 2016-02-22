class Access::PermissionsController < AccessController

  layout "application_loggedin"

  def index
    query = generic_table_aggregated_queries('permissions','permissions.created_at')
    begin
      @permissions = Permission
                         .where("permissions.access_id LIKE ? OR " +
                                    "permissions.can LIKE ? ",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%")
                         .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @permissions = Kaminari.paginate_array(@permissions).page(params[:page]).per(query[:current_limit])
    rescue => ex
      puts ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/access/permissions/index'
  end

  def initialize_form
    initialize_form_variables('PERMISSION',
                              'Create a new permission for a user',
                              'access/permissions/permission_form',
                              'permission')
    @active_permissions_uniq = Permission.all.uniq
    initialize_employee_selection
  end

  def search_suggestions
    permissions = Permission
                      .where("permission.access_id LIKE ?","%#{params[:query]}%")
                      .pluck("permission.access_id")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + permissions.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_permission = Permission.new
    @accesses = Access.all()
    generic_singlecolumn_form(@selected_permission)
  end

  def edit
    initialize_form
    @selected_permission = Permission.find(params[:id])
    @accesses = Access.all()
    generic_singlecolumn_form(@selected_permission)
  end

  def delete
    generic_delete_model(Permission,controller_name)
  end

  def process_permission_form(myPermission)
    begin
      myPermission[:can] = params[:permission][:can]
      myPermission[:access_id] = params[:permission][:access_id]
      myPermission[:remark] = params[:permission][:remark]
      myPermission.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myPermission = Permission.new()
    flash[:general_flash_notification] = 'Permission Created!'
    process_permission_form(myPermission)
  end

  def update
    myPermission = Permission.find(params[:permission][:id])
    flash[:general_flash_notification] = 'Permission Updated: ' + params[:permission][:id]
    process_permission_form(myPermission)
  end

end