module HumanResourcesHelper

  def signed_amount(sign, amount)
    if sign
      amount = amount
    else
      amount = amount*(-1)
    end
    amount
  end

  def convert_base_rate_amount_to_hours(amount,period_of_time)
    if period_of_time == 'HOUR'
      amount_in_hour = amount
    elsif period_of_time == 'DAY'
      amount_in_hour = amount/24
    elsif period_of_time == 'MONTH'
      amount_in_hour = amount/730.484398
    elsif period_of_time == 'WEEK'
      amount_in_hour = amount/168
    elsif period_of_time == 'YEAR'
      amount_in_hour = amount/8765.81277
    else
    end
    amount_in_hour.round(2)
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

  def categorize_work_hours(start_time, end_time, latest_end_time_for_constant)
    #Initialize Variables
    start_time = Time.parse(start_time)
    end_time = Time.parse(end_time)
    uncutoff_start_time = start_time
    uncutoff_end_time = end_time
    lunch_break_difference = 0
    regular_work_hours = 0
    overtime = 0
    night_shift_differential_hours = 0
    ot_nsd = 0
    nsd_morning_difference = 0
    nsd_night_difference = 0
    night_shift_differential_start = Time.parse(get_constant('human_resources.night_shift_differential_start', latest_end_time_for_constant))
    night_shift_differential_end = Time.parse(get_constant('human_resources.night_shift_differential_end', latest_end_time_for_constant))

    #NSD Cutoff
    if start_time.between?( Time.parse('00:00:01'),night_shift_differential_end)
      nsd_morning_difference = night_shift_differential_end - start_time
      uncutoff_start_time = start_time
      start_time = night_shift_differential_end
    end
    if end_time.between?(night_shift_differential_start, Time.parse('23:59:59'))
      nsd_night_difference = end_time - night_shift_differential_start
      uncutoff_end_time = end_time
      end_time = night_shift_differential_start
    end

    start_lunch_break = Time.parse(get_constant('human_resources.start_lunch_break', latest_end_time_for_constant))
    end_lunch_break = Time.parse(get_constant('human_resources.end_lunch_break', latest_end_time_for_constant))

    #Lunchbreak Deduction
    if (start_time..end_time).overlaps?(start_lunch_break..end_lunch_break)
      if start_time.between?(start_lunch_break,end_lunch_break)
        lunch_break_difference = end_lunch_break - start_time
      elsif end_time.between?(start_lunch_break,end_lunch_break)
        lunch_break_difference = end_time - start_lunch_break
      else
        lunch_break_difference = 3600
      end
    end

    regular_work_hours = ((((end_time - start_time) - lunch_break_difference)/3600) )
    night_shift_differential_hours = ((nsd_morning_difference+nsd_night_difference)/3600)

    #NSD Overlap
    morning_overlap = end_time.between?(Time.parse('00:00:01'), night_shift_differential_end)
    night_overlap = start_time.between?(night_shift_differential_start, Time.parse('23:59:59'))
    if (morning_overlap == true )||( night_overlap == true)
      regular_work_hours = 0
    end

    #exclusively start/end inside NSD's
    total_overlap_nsd_morning = (uncutoff_start_time.between?(Time.parse('00:00:01'),night_shift_differential_end) == true) && (uncutoff_end_time.between?(Time.parse('00:00:01'),night_shift_differential_end) == true)
    total_overlap_nsd_night = (uncutoff_start_time.between?(night_shift_differential_start,Time.parse('23:59:59')) == true) && (uncutoff_end_time.between?(night_shift_differential_start,Time.parse('23:59:59')) == true)
    if (total_overlap_nsd_morning == true )||( total_overlap_nsd_night == true)
      night_shift_differential_hours = ((uncutoff_end_time - uncutoff_start_time)/3600)
      #night_shift_differential_hours = 'H'
    end

    #Limit Regular Work Hours
    if regular_work_hours > 8
      overtime = regular_work_hours - 8
      ot_nsd = night_shift_differential_hours
      night_shift_differential_hours = 0
      regular_work_hours = 8
    end

    work_hours_hash = {:regular_work_hours => regular_work_hours.round(2),
                       :overtime => overtime.round(2),
                       :night_shift_differential_hours => night_shift_differential_hours.round(2),
                       :ot_nsd => ot_nsd.round(2),
    }
    work_hours_hash
  end

  def base_rates(employee_id, current_date_of_attendance, restday_token)
    total_regular_sum = 0
    base_sum = 0
    ot_sum = 0
    nsd_sum = 0
    ot_nsd_sum = 0
    base_rates = BaseRate.where('(employee_id = ?) AND ( ? BETWEEN start_of_effectivity AND end_of_effectivity)', "#{employee_id}","#{current_date_of_attendance}");

    base_rates.each do |base_rate|
      if (base_rate[:rate_type] == 'base' || base_rate[:rate_type] == 'allowance')
        current_amount = convert_base_rate_amount_to_hours(base_rate[:amount], base_rate[:period_of_time])
        if base_rate[:signed_type]
          total_regular_sum = total_regular_sum + current_amount
        else
          total_regular_sum = total_regular_sum + (current_amount*(-1))
        end
      end
    end

    base_rates.each do |base_rate|
      if base_rate[:rate_type] = 'base'
        current_amount = convert_base_rate_amount_to_hours(base_rate[:amount], base_rate[:period_of_time])
        if base_rate[:signed_type]
          base_sum = base_sum + current_amount
        else
          base_sum = base_sum + (current_amount*(-1))
        end
      end
    end

    current_date = Date.strptime(current_date_of_attendance, "%Y-%m-%d")
    holiday_token = false
    non_working_token = false
    double_holiday_token = false
    holiday_type = false
    holidays = Holiday.includes(:holiday_type).joins(:holiday_type)
    holidays.each do |holiday|
      if current_date == holiday[:date_of_implementation]
        holiday_type = holiday.holiday_type.type_name
        if holiday_type == 'Regular'
          holiday_token = true
        elsif holiday_type == 'Special Non-Working'
          non_working_token = true
        elsif holiday_type == 'Double'
          double_holiday_token = true
        end
      end
    end

    #restday processing
    # holdiay + rest0day
    # holiday
    # non working holiday
    # rest day
    # double holiday
    # else
    original_total_regular_sum = total_regular_sum
    if (holiday_token == true) && (restday_token == true)
      total_regular_sum = (total_regular_sum*2)+((base_sum*2)*0.3)
      ot_sum = base_sum*3.38
      nsd_sum = original_total_regular_sum*2.6*1.1
      ot_nsd_sum = ot_sum*1.1
    elsif (non_working_token == true) && (restday_token == true)
      total_regular_sum = total_regular_sum*1.5
      ot_sum = base_sum*1.95
      nsd_sum = total_regular_sum*1.1
      ot_nsd_sum = ot_sum*1.1
    elsif (double_holiday_token == true) && (restday_token == true)
      total_regular_sum = total_regular_sum*3
      ot_sum = base_sum*5.07
      nsd_sum = original_total_regular_sum*3.9*1.1
      ot_nsd_sum = ot_sum*1.1
    elsif holiday_token
      total_regular_sum = total_regular_sum*2
      ot_sum = base_sum*2.6
      nsd_sum = total_regular_sum*1.1
      ot_nsd_sum = ot_sum*1.1
    elsif non_working_token
      total_regular_sum = total_regular_sum*1.3
      ot_sum = base_sum*1.69
      nsd_sum = total_regular_sum*1.1
      ot_nsd_sum = ot_sum*1.1
    elsif double_holiday_token
      total_regular_sum = total_regular_sum*3
      ot_sum = base_sum*3.9
      nsd_sum = original_total_regular_sum*3.3*1.1
      ot_nsd_sum = ot_sum*1.1
    elsif restday_token
      total_regular_sum = total_regular_sum*1.3
      ot_sum = base_sum*1.69
      nsd_sum = total_regular_sum*1.1
      ot_nsd_sum = ot_sum*1.1
    else
      total_regular_sum = total_regular_sum
      ot_sum = base_sum*1.25
      nsd_sum = total_regular_sum*1.1
      ot_nsd_sum = (ot_sum*1.1)
    end


    rate_array = {:reg => total_regular_sum.round(2), :ot => ot_sum.round(2),:nsd => nsd_sum.round(2),:ot_nsd => ot_nsd_sum.round(2), :base => base_sum.round(2)}
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
