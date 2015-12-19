module ApplicationHelper

  def generic_table_options()

  end

  def get_current_duty_status( employee_ID )
    currentEmployee = Employee.includes(:duty_status).joins(:duty_status).where("(employees.id = ?)", "#{employee_ID}").order('duty_statuses.date_of_effectivity DESC').first
    return currentEmployee.duty_status.first.active
  end

  #Boolean to Words
  def boolean_to_words(x)
    if x == 1
      return 'true'
    else
      return 'false'
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:order_by] && params[:arrangement] == "asc") ? "desc" : "asc"
    link_to title, :order_by => column, :arrangement => direction, :employee_id => @employee_id, :offset => @offset
  end

  def generic_table_theadlink(link_action, order_parameter, table_orientation)
    render(:partial => 'core_partials/generic_table_theadlink', :locals => { :link_action => link_action, :order_parameter => order_parameter, :table_orientation => table_orientation})
  end

  def generic_table_footer(add_link, reset_search_redirect, result_set)
    render(:partial => 'core_partials/generic_table_footer', :locals => { :add_link => add_link, :reset_search_redirect => reset_search_redirect, :result_set => result_set})
  end

  def generic_table_search(form_input_id, form_link, placeholdertext, service_url, unique_flash_variable)
    render(:partial => 'core_partials/generic_table_search', :locals => {:form_input_id => form_input_id, :form_link => form_link, :placeholdertext => placeholdertext,  :service_url => service_url, :unique_flash_variable => unique_flash_variable})
  end

  def generateReadableID()
    generatedID = SecureRandom.random_number(999999999).to_s.rjust(9,'0')
    while( self.where(id: generatedID) )
      generatedID = SecureRandom.random_number(999999999).to_s.rjust(9,'0')
    end
    self.id = generatedID
  end

  def placeholder_assignment(placeholdervariable, placeholdertext)
    if( (placeholdervariable.present? == false) || placeholdervariable == "")
      placeholdervariable = placeholdertext
    end
    return placeholdervariable
  end

  def renderCorePartial(partialname,partialinks={})
    render(:partial => "core_partials/"+partialname, :locals => partialinks)
  end

  def renderSuccessPartial(headerMessage, bodyMessage, nextLinks)
    render(:partial => "core_partials/acknowledgement_success", :locals => { :headerMessage => headerMessage, :bodyMessage => bodyMessage, :nextLinks => nextLinks})
  end

  def renderFormPartial(partialname,partialinks={})
    render(:partial => "form_partials/"+partialname, :locals => partialinks)
  end

  def renderItemListerButtons(description,add,minus)
    renderCorePartial("itemlisterbuttons",{ :description => description, :add => add, :minus => minus})
  end

  def error_messages_for(object)
    render(:partial => "core_partials/formerrors", :locals => {:object => object})
  end

  def generateRandomString()
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    return (0...64).map { o[rand(o.length)] }.join.downcase!
  end

  def highlightMenuButtons()
  end

  def displayCollectiveResponses()
    render(:partial => "core_partials/collective_form_responses")
  end

end
