module ApplicationHelper

  def translate_period_of_time_into_seconds(period_of_time)
    if period_of_time == 'YEAR'
      number_of_seconds = 31556926
    elsif period_of_time == 'MONTH'
      number_of_seconds = 2629744
    elsif period_of_time == 'WEEK'
      number_of_seconds = 604800
    elsif period_of_time == 'DAY'
      number_of_seconds = 86400
    end
    return number_of_seconds
  end

  def insertTimeIntoDate(myDate, myTime)
    return DateTime.new(myDate.year, myDate.month, myDate.day, myTime.hour, myTime.min, myTime.sec, "+8" )
  end

  def whatHoliday( current_date )
    holidays = Holiday.all
    what_holiday = false
    holidays.each do |holiday|
      if holiday.date_of_implementation == current_date
        what_holiday = holiday.name
      end
    end
    return what_holiday
  end

  def whatRestDay(employee_id, current_day)
    rest_day = RestDay
                   .where("(employee_id = ?) AND (date_of_effectivity <= ?)", "#{employee_id}", "#{current_day}")
                   .order('rest_days.date_of_effectivity DESC').first
    what_rest_day = false
    if rest_day.day == current_day.strftime("%A")
      what_rest_day = rest_day.id
    end
    return what_rest_day
  end

  def get_current_duty_status( employee_ID )
    currentEmployee = Employee
                          .includes(:duty_status)
                          .joins(:duty_status)
                          .where("(employees.id = ?)", "#{employee_ID}")
                          .order('duty_statuses.date_of_effectivity DESC').first
    return currentEmployee.duty_status.first.active
  end

  def get_duration_regular_work_hours(employee_ID, specific_day)
    currentEmployee = Employee
                          .includes(:regular_work_period)
                          .joins(:regular_work_period)
                          .where("(employees.id = ?) AND (regular_work_periods.date_of_effectivity <= ?)", "#{employee_ID}", "#{specific_day}")
                          .order("regular_work_periods.date_of_effectivity DESC").first
    number_of_seconds = ((currentEmployee.regular_work_period.end_time - currentEmployee.regular_work_period.start_time))
    if number_of_seconds < 0
      number_of_seconds = ((currentEmployee.regular_work_period.end_time - currentEmployee.regular_work_period.start_time)).abs
    end
    return (number_of_seconds/3600).round
  end

  def get_duration_actual_work_hours(employee_ID, specific_day)
    attendances = Attendance.includes(:employee).joins(:employee).where("(employees.id = ?) AND (attendances.date_of_attendance LIKE ?)", "#{employee_ID}", "#{specific_day.strftime("%Y-%m-%d")}%").order('attendances.created_at DESC')
    total_seconds = 0
    attendances.each do |attendance|
      time_in = attendance[:timein]
      time_out = attendance[:timeout]
      my_seconds = (time_in - time_out).abs
      total_seconds = my_seconds + total_seconds
      end
    return (total_seconds/3600).round
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

  def generic_actor_profile_link(my_ID, my_name)
    render(:partial => 'core_partials/generic_actor_profile_link', :locals => {:my_ID => my_ID, :my_name => my_name})
  end

  def generic_form_edit_id_indicator(selected_model_id)
    render(:partial => 'core_partials/generic_form_edit_id_indicator', :locals => {:selected_model_id => selected_model_id})
  end

  def generic_form_footer(selected_model_id)
    render(:partial => 'core_partials/generic_form_footer', :locals => {:selected_model_id => selected_model_id})
  end

  def generic_table_actions(model_id)
    render(:partial => 'core_partials/generic_table_actions', :locals => { :model_id => model_id})
  end

  def generic_table_theadlink(order_parameter, table_orientation)
    render(:partial => 'core_partials/generic_table_theadlink', :locals => {:order_parameter => order_parameter, :table_orientation => table_orientation})
  end

  def generic_table_footer(result_set)
    render(:partial => 'core_partials/generic_table_footer', :locals => {:result_set => result_set})
  end

  def generic_table_search()
    render(:partial => 'core_partials/generic_table_search')
  end

  def generic_actor_search()
    render(:partial => 'core_partials/generic_actor_search')
  end

  def generic_search_footer(result_set)
    render(:partial => 'core_partials/generic_search_pagination', :locals => {:result_set => result_set})
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
