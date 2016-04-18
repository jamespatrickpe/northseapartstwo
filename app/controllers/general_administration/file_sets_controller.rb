class GeneralAdministration::FileSetsController < GeneralAdministrationController


  def index
    query = generic_table_aggregated_queries('file_sets','file_sets.created_at')
    begin
      @file_sets = FileSet
                      .where("file_sets.file LIKE ? OR " +
                                 "file_sets.label LIKE ?",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @file_sets = Kaminari.paginate_array(@file_sets).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/general_administration/file_set/index'
  end


  def initialize_form
    initialize_form_variables('SYSTEM FILE SETS',
                              'general_administration/file_sets/file_set_form',
                              'file_sets')
    initialize_employee_selection
  end

  def search_suggestions
    file_set = FileSet
                   .where("file_sets.file LIKE ?","%#{params[:query]}%")
                   .pluck("file_sets.file")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + file_set.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_file_set = FileSet.new
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_single_column_form(@selected_file_set)
  end

  def edit
    initialize_form
    @selected_file_set = FileSet.find(params[:id])
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_single_column_form(@selected_file_set)
  end

  def delete
    generic_delete_model(FileSet,controller_name)
  end

  def process_file_set_form(myFileSet)
    begin
      myFileSet[:file] = params[:file_sets][:file]
      myFileSet[:label] = params[:file_sets][:label]
      myFileSet[:rel_file_set_id] = params[:file_sets][:rel_file_set_id]
      myFileSet[:rel_file_set_type] = params[:file_sets][:rel_file_set_type]
      myFileSet.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myFileSet = FileSet.new()
    flash[:general_flash_notification] = 'File Set Created!'
    process_file_set_form(myFileSet)
  end

  def update
    myFileSet = FileSet.find(params[:file_sets][:id])
    flash[:general_flash_notification] = 'File Set Updated: ' + params[:file_sets][:id]
    process_file_set_form(myFileSet)
  end

end