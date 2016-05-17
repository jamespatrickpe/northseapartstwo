module ApplicationHelper

  def get_constant(constant_name, latest_end_time_for_constant)
    constant = ::Constant.where('(constant_type = ?) AND ( date_of_implementation <= ? )',
                                "#{constant_name}",
                                "#{latest_end_time_for_constant}"
    ).order('date_of_implementation DESC').first
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

  def generateRandomString()
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    return (0...64).map { o[rand(o.length)] }.join.downcase!
  end

  def get_all_entities_involved_with_a_model(model, query, modelId)
    involvedActorObjects ||= []
    involvedBranchObjects ||= []
    related = model.where(query, modelId)
    # get all actors
    related.each do |ea|
      if Actor.exists?(ea[:system_actor_id])
        involvedActorObjects.push(Actor.find(ea[:system_actor_id]))
      end
    end
    #get all branches
    related.each do |ea|
      if Branch.exists?(ea[:system_actor_id])
        involvedBranchObjects.push(Branch.find(ea[:system_actor_id]))
      end
    end
    # for future addition, just add another loop to obtain involved object via their ID
    actorsInvolved = involvedActorObjects + involvedBranchObjects
    return actorsInvolved
  end

  def overview_panel(path, name = '')
    render(:partial => 'common_partials/overview_panel',
           :locals => {:path => path,
                       :name => name})
  end

end
