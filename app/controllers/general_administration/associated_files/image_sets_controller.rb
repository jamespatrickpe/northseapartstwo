class GeneralAdministration::ImageSetsController < GeneralAdministrationController


  def index
    query = generic_table_aggregated_queries('image_sets','image_sets.created_at')
    begin
      @image_sets = ImageSet
                       .where("image_sets.picture LIKE ? OR " +
                                  "image_sets.remark LIKE ?",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%")
                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @image_sets = Kaminari.paginate_array(@image_sets).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/general_administration/image_set/index'
  end


  def initialize_form
    initialize_form_variables('SYSTEM IMAGE SETS',
                              'general_administration/image_sets/image_set_form',
                              'image_sets')
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
    generic_single_column_form(@selected_image_set)
  end

  def edit
    initialize_form
    @selected_image_set = ImageSet.find(params[:id])
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_single_column_form(@selected_image_set)
  end

  def delete
    generic_delete_model(ImageSet,controller_name)
  end

  def process_image_set_form(myImageSet)
    begin
      myImageSet[:picture] = params[:image_sets][:picture]
      myImageSet[:remark] = params[:image_sets][:remark]
      myImageSet[:priority] = params[:image_sets][:priority]
      myImageSet[:rel_image_set_id] = params[:image_sets][:rel_image_set_id]
      myImageSet[:rel_image_set_type] = params[:image_sets][:rel_image_set_type]
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
    myImageSet = ImageSet.find(params[:image_sets][:id])
    flash[:general_flash_notification] = 'Image Set Updated: ' + params[:image_sets][:id]
    process_image_set_form(myImageSet)
  end

end