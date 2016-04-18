class GeneralAdministration::DigitalsController < GeneralAdministrationController

  def index
    query = generic_table_aggregated_queries('digitals','created_at')
    begin
      @search = Digital.search do
        fulltext query[:search_field]
        order_by :created_at,
                 query[:order_orientation].parameterize.underscore.to_sym
        paginate :page => params[:page],
                 :per_page => query[:current_limit]
      end
      @digitals = @search.results
    rescue => ex
      index_error(ex)
    end
    render_index(general_administration_digitals_path)
  end


  def initialize_form
    initialize_form_variables('DIGITAL',
                              'general_administration/contact_details/digitals/digital_form',
                              'digital')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_digital = Digital.new
    @actors1 = Actor.all()
    @actors2 = Branch.all()
    generic_single_column_form(@selected_digital)
  end

  def edit
    initialize_form
    @selected_digital = Digital.find(params[:id])
    @actorsInvolved ||= []

    # @digital_actor_rel = TelephonesActor.find_by_digital_id(params[:id])
    @digital_actor_rel = DigitalsActor.where("digitals_actors.digital_id = ?", "#{params[:id]}")

    involvedActorObjects ||= []
    involvedBranchObjects ||= []

    @digital_actor_rel.each do |ea|
      if Actor.exists?(ea[:actor_id])
        involvedActorObjects.push(Actor.find(ea[:actor_id]))
      else
        puts 'ID in use does not belong to an Actor'
      end
    end

    @digital_actor_rel.each do |ea|
      if Branch.exists?(ea[:actor_id])
        involvedBranchObjects.push(Branch.find(ea[:actor_id]))
      else
        puts 'ID in use does not belong to a Branch'
      end
    end

    @actorsInvolved = involvedActorObjects + involvedBranchObjects

    @actors1 = Actor.all()
    @actors2 = Branch.all()

    @actorsInvolved.compact.uniq!
    generic_single_column_form(@selected_digital)
  end

  def delete
    digital_to_be_deleted = Digital.find(params[:id])
    flash[:general_flash_notification] = 'Digital information url:  ' + digital_to_be_deleted.url + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'

    # deletes all related actors with the digital before deleting the actual digital object
    mapped_digital_actors = TelephonesActor.where("digitals_actors.digital_id = ?", "#{params[:id]}")
    mapped_digital_actors.each do |a|
      a.destroy
    end

    digital_to_be_deleted.destroy
    redirect_to :action => "index"
  end

  def process_digital_form(myDigital)
    begin
      myDigital[:url] = params[:digital][:url]
      myDigital[:remark] = params[:digital][:remark]
      myDigital.save!

      # after creating the new digital, iterate through all the actors involved and maps them with the digital
      actorsInvolved = params[:digital][:digitalactors]
      actorsInvolved.each_with_index do |p , index|
        actor = DigitalsActor.new
        actor[:actor_id] = actorsInvolved.values[index]
        actor[:digital_id] = myDigital.id
        actor.save!
      end

      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myDigital = Digital.new()
    flash[:general_flash_notification] = 'Digital address information created!'
    process_digital_form(myDigital)
  end

  def update
    myDigital = Digital.find(params[:digital][:id])
    flash[:general_flash_notification] = 'Digital address information ' + params[:digital][:url]
    process_digital_form(myDigital)
  end

  def search_suggestions
    digitals = Digital
                    .where("digitals.url LIKE ?","%#{params[:query]}%")
                    .pluck("digitals.url")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + digitals.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end
end