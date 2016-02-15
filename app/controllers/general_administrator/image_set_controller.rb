class GeneralAdministrator::ImageSetController < GeneralAdministratorController


  def index
    query = generic_table_aggregated_queries('image_sets','image_sets.created_at')
    begin
      @image_sets = ImageSet
                       .where("image_sets.picture LIKE ? OR " +
                                  "image_sets.description LIKE ?",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%")
                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @image_sets = Kaminari.paginate_array(@image_sets).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/general_administrator/image_set/index'
  end


  def initialize_form
    initialize_form_variables('SYSTEM IMAGE SETS',
                              'Create a new image within the system',
                              'general_administrator/image_set/image_set_form',
                              'image_set')
    initialize_employee_selection
  end

  def search_suggestions
    image_set = ImageSet
                   .where("image_sets.picture LIKE ?","%#{params[:query]}%")
                   .pluck("image_sets.picture")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + image_set.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_image_set = ImageSet.new
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_singlecolumn_form(@selected_image_set)
  end

  def edit
    initialize_form
    @selected_image_set = ImageSet.find(params[:id])
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_singlecolumn_form(@selected_image_set)
  end

  def delete
    generic_delete_model(ImageSet,controller_name)
  end

  def process_image_set_form(myImageSet)
    begin
      myImageSet[:picture] = params[:image_set][:picture]
      myImageSet[:description] = params[:image_set][:description]
      myImageSet[:priority] = params[:image_set][:priority]
      myImageSet[:rel_image_set_id] = params[:image_set][:rel_image_set_id]
      myImageSet[:rel_image_set_type] = params[:image_set][:rel_image_set_type]
      myImageSet.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myImageSet = ImageSet.new()
    flash[:general_flash_notification] = 'Image Set Created!'
    process_image_set_form(myImageSet)
  end

  def update
    myImageSet = ImageSet.find(params[:image_set][:id])
    flash[:general_flash_notification] = 'Image Set Updated: ' + params[:image_set][:id]
    process_image_set_form(myImageSet)
  end

end