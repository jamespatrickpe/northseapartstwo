module ActorProfile

  def initialize_actor_selection
    @employees = Employee.includes(:system_account).joins(:system_accounts)
  end

  def actor_profile
    if( params[:system_account_id] )
      @selected_actor = SystemAccount.find(params[:system_account_id])
      @selected_access = Access.find_by_actor_id(@selected_actor.id)
      @selected_biodata = Biodatum.find_by_actor_id(@selected_actor.id)
      @selected_address_set = Address.where("rel_model_id = ?", "#{@selected_actor.id}")
      @selected_telephone_set = Telephone.where("rel_model_id = ?", "#{@selected_actor.id}")
      @selected_digital_set = Digital.where("rel_model_id = ?", "#{@selected_actor.id}")
      @selected_file_set = FileSet.where("rel_file_set_id = ? AND rel_file_set_type = 'Actor'", "#{@selected_actor.id}")
      @selected_image_set = ImageSet.where("rel_image_set_id = ? AND rel_image_set_type = 'Actor'", "#{@selected_actor.id}").order('priority DESC')
    end
    @selected_actor ||= Actor.new
  end

end