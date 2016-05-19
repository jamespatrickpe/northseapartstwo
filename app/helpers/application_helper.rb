module ApplicationHelper

  def get_constant(constant_name, latest_end_time_for_constant)
    constant = ::Constant.where('(constant_type = ?) AND ( date_of_effectivity <= ? )',
                                "#{constant_name}",
                                "#{latest_end_time_for_constant}"
    ).order('date_of_effectivity DESC').first
    constant[:value]
  end

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

  def display_if_rest_day(employee_id, current_day, latest_end_time_for_constant)
    rest_day = RestDay
                   .where("(employee_id = ?) AND (date_of_effectivity <= ?)", "#{employee_id}", "#{latest_end_time_for_constant}")
                   .order('rest_days.date_of_effectivity ASC').first
    if rest_day.present?
      if rest_day[:day] == current_day
        "( REST DAY )"
      end
    end
  end

  def display_if_holiday(current_day)
    holiday = Holiday
                  .where("(date_of_implementation = ?)", current_day)
                  .order('holidays.date_of_implementation ASC').first
    if holiday.present?
      holiday[:name]
    end
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

  def get_all_entities_involved_with_a_model(model, query, modelId)
    involvedActorObjects ||= []
    involvedBranchObjects ||= []
    related = model.where(query, modelId)
    # get all actors
    related.each do |ea|
      if Actor.exists?(ea[:actor_id])
        involvedActorObjects.push(Actor.find(ea[:actor_id]))
      end
    end
    #get all branches
    related.each do |ea|
      if Branch.exists?(ea[:actor_id])
        involvedBranchObjects.push(Branch.find(ea[:actor_id]))
      end
    end
    # for future addition, just add another loop to obtain involved object via their ID
    actorsInvolved = involvedActorObjects + involvedBranchObjects
    return actorsInvolved
  end

  def get_all_employees_from_a_branch(branchId)
    emps = Employee.where("(branch_id = ?)", "#{branchId}")
    emps.each do |e|
      puts e.actor.name
    end
    return emps
  end


  # in starter seed
  # iterate over all employees, computing all of their income taxes and inserting it into the database
  # provide a more realistic dataset
  # for CRUD model, decide if to use existing Institutional_Adjustment model or just create a brand new Income_Tax model

  def compute_individual_tax_rate_monthly(employee_id)
    # get employee from employee_id
    # get base_rate from employee
    # return compute_individual_tax_rate(base_rate)
  end

  def compute_individual_tax_rate_week(employee_id)
    # get employee from employee_id
    # get base_rate from employee
    # check if base_rate.type = WEEK
    # if WEEK
    #     validate if employee has complete attendance
    #         if employee has perfect week attendance, proceed
    #                return compute_individual_tax_rate(base_rate)
    #
    # -- does it still count as full even if employee has absent?
    # -- what do you consider as a working week? do you have service on weekends?
    # -- I am about to code this as if week will be treated as bulk, not as a set of days
  end

  def compute_individual_tax_rate_daily(employee_id, compute_from, compute_to)
    # get employee from employee_id
    # get base_rate from employee
    # check if base_rate.type = DAY
    # if DAY
    #     iterate over all days within the range that the employee has attendance
    #     ADD each daily rate to a SUM
    #     TAKE INTO CONSIDERATION REGULAR WORKING PERIOD OF EMPLOYEE
    #     return compute_individual_tax_rate(SUM)
    #
    # -- do you have undertime status if employee failed to complete his
    #    designated REGULAR WORKING PERIOD? because this will surely affect the income and the corresponding tax
  end

  def compute_individual_tax_rate_hourly(employee_id, compute_from, compute_to)
    # get employee from employee_id
    # get base_rate from employee
    # check if base_rate.type = HOURLY
    # if HOURLY
    #     iterate over all days within the range that the employee has attendance
    #     ADD each hourly rate to a SUM
    #     TAKE INTO CONSIDERATION REGULAR WORKING PERIOD OF EMPLOYEE
    #     return compute_individual_tax_rate(SUM)
  end

  def compute_individual_tax_rate(base_rate)
    # if < 10,000,            tax_rate = base_rate * 0.05
    # if 10,001 to 30,000     tax_rate = 500 + ((base_rate - 10,000) * 0.1)
    # if 30,001 to 70,000     tax_rate = 2,500 + ((base_rate - 30,000) * 0.15)
    # if 70,001 to 140,000    tax_rate = 8,500 + ((base_rate - 70,000) * 0.20)
    # if 140,001 to 250,000   tax_rate = 22,500 + ((base_rate - 140,000) * 0.25)
    # if 250,001 to 500,000   tax_rate = 50,000 + ((base_rate - 250,000) * 0.30)
    # if > 500,000            tax_rate = 125,000 + ((base_rate - 500,000) * 0.32)
    # return tax_rate
  end

end
