module HumanResourcesHelper

  def get_constant(constant_name, latest_end_time_for_constant)
    constant = ::Constant.where('(constant_type = ?) AND ( date_of_effectivity <= ? )',
                                "#{constant_name}",
                                "#{latest_end_time_for_constant}"
    ).order('date_of_effectivity ASC').first
    constant
  end

  def remove_lunch_break(start_time, end_time)
    lunch_break_start_constant = get_constant('human_resources.start_lunch_break', time_of_consideration)
    start_lunch_break = Time.strptime((::Constant.find_by_constant_type('human_resources.start_lunch_break'))[:value], '%Y-%m-%d %H:%M:%S')
    end_lunch_break = Time.strptime((::Constant.find_by_constant_type('human_resources.end_lunch_break'))[:value], '%Y-%m-%d %H:%M:%S')
    is_crossed_lunch_break = (start_time..end_time).overlaps?(start_lunch_break..end_lunch_break)
    lunch_break_difference = 0
    if is_crossed_lunch_break
      if ( start_time.between?(start_lunch_break,end_lunch_break) ) && ( end_time.between?(start_lunch_break,end_lunch_break) )
      elsif start_time.between?(start_lunch_break,end_lunch_break)
        lunch_break_difference = end_lunch_break - start_time
      elsif end_time.between?(start_lunch_break,end_lunch_break)
        lunch_break_difference = end_time - start_lunch_break
      else
        lunch_break_difference = 3600
      end
    end
    work_hours_without_lunch_break = (((end_time - start_time) - lunch_break_difference)/3600)
  end

  def categorize_regular_hours(start_time, end_time, latest_end_time_for_constant)
    night_shift_differential_start = get_constant('night_shift_differential_start', latest_end_time_for_constant)
  end

  def categorize_OT_hours(start_time, end_time)

  end

  def categorize_NSD_hours(start_time, end_time)

  end

  def categorize_OTNSD_hours(start_time, end_time)

  end

  def remaining_vale_balance(parent_vale_id)

    my_vale = Vale.find(parent_vale_id)
    my_vale_adjustments = ValeAdjustment.where(vale_id: parent_vale_id)
    current_balance = my_vale[:amount]
    iteration = translate_period_of_time_into_seconds(my_vale[:period_of_deduction])
    current_time = my_vale[:date_of_effectivity]
    next_time = current_time + iteration

    while(Time.now > current_time)
      adjustment_in_period_token = false
      my_vale_adjustments.each do |my_vale_adjustment|
        if my_vale_adjustment[:date_of_effectivity].between?(current_time, next_time)
          adjustment_in_period_token = true
          my_vale_adjustment[:signed_type] ?
              ( current_balance = current_balance + my_vale_adjustment[:amount] ) :
              ( current_balance = current_balance - my_vale_adjustment[:amount] )
        end
      end
      (adjustment_in_period_token == false) ? ( current_balance = current_balance - my_vale[:amount_of_deduction] ):()
      (current_balance < 0) ? (break;) : ()
      current_time = current_time + iteration
      next_time = current_time + iteration
    end

    (current_balance < 0) ? (current_balance = "PAID") : ()
    return current_balance

  end

end
