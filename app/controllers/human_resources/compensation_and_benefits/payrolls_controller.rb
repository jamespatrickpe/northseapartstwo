class HumanResources::CompensationAndBenefits::PayrollsController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('payrolls','payrolls.created_at')
    begin
      @payrolls = Payroll.includes(employee: [:actor])
                      .joins(employee: [:actor])
                      .where("actors.name LIKE ? OR " +
                                 "payrolls.id LIKE ? OR " +
                                 "payrolls.article LIKE ? OR " +
                                 "payrolls.applicability LIKE ? OR " +
                                 "payrolls.date_of_effectivity LIKE ? OR " +
                                 "payrolls.remark LIKE ? OR " +
                                 "payrolls.created_at LIKE ? OR " +
                                 "payrolls.updated_at LIKE ?",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @payrolls = Kaminari.paginate_array(@payrolls).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_and_benefits/payrolls/index'
  end

  def initialize_form
    initialize_form_variables('PAYROLL',
                              'Set the Settings of an Employee Payrol',
                              'human_resources/compensation_and_benefits/payrolls/payroll_form',
                              'payroll')
    initialize_employee_selection
  end

  def search_suggestions
    generic_employee_name_search_suggestions(Payroll)
  end

  def new
    initialize_form
    @selected_payroll = Payroll.new
    generic_bicolumn_form_with_employee_selection(@selected_payroll)
  end

  def edit
    initialize_form
    @selected_payroll = Payroll.find(params[:id])
    generic_bicolumn_form_with_employee_selection(@selected_payroll)
  end

  def process_payroll_form(payroll)
    begin
      employee = Employee.find(params[:payroll][:employee_id])
      payroll.employee = employee
      payroll.article = params[:payroll][:article]
      payroll.applicability = params[:payroll][:applicability]
      payroll.date_of_effectivity = params[:payroll][:date_of_effectivity]
      payroll.remark = params[:payroll][:remark]
      payroll.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def delete
    generic_delete_model(Payroll, controller_name)
  end

  def update
    payroll = Payroll.find(params[:payroll][:id])
    flash[:general_flash_notification] = 'Payroll Updated'
    process_payroll_form(payroll)
  end

  def create
    payroll = Payroll.new()
    flash[:general_flash_notification] = 'Payroll Created'
    process_payroll_form(payroll)
  end

  def employee

    # Initial Variables
    current_employee_id = params[:id]
    @employees = Employee.all
    current_employee_id.present? ?
      (@selected_employee = Employee.find(current_employee_id)) :
      (@selected_employee = Employee.new())
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    # Convert Duty Status to Valid Periods
    @my_duty_statuses = DutyStatus.where('employee_id = ?', "#{current_employee_id}")
                                  .order('date_of_effectivity ASC')

    @valid_periods = Array.new
    start_period = ''
    end_period = ''
    searching_for_next = true
    @my_duty_statuses.each_with_index do |duty_status, index|
      if duty_status[:active] == searching_for_next
        if duty_status[:active] == true
          start_period = duty_status[:date_of_effectivity].strftime("%Y-%m-%d")
          searching_for_next = false
        end
        if duty_status[:active] == false
          end_period = duty_status[:date_of_effectivity].strftime("%Y-%m-%d")
          searching_for_next = true
        end
      end
      if start_period.present? && end_period.present?
        @valid_periods.push({:start_period => start_period, :end_period => end_period})
        start_period = ''
        end_period = ''
      end
      if start_period.present? && ( index == @my_duty_statuses.size - 1 )
        @valid_periods.push({:start_period => start_period, :end_period => DateTime.now.strftime("%Y-%m-%d") })
      end
    end

    # Extract Attendances
    @selected_attendances = ::Attendance
                               .where('(attendances.employee_id = ?) AND ( attendances.date_of_attendance BETWEEN ? AND ? )',
                                      "#{current_employee_id}",
                                      "#{@start_date}",
                                      "#{@end_date}"
                               )

    # Keep Attendances within the Valid Period
    @selected_attendances = @selected_attendances.select{ |attendance|
      conditional = ''
      @valid_periods.each do |valid_period|
        conditional = attendance[:date_of_attendance].between?(Date.parse( valid_period[:start_period] ),Date.parse( valid_period[:end_period] ) )
        if conditional == true
          break;
        end
      end
      conditional
    }

    # Count Valid Periods
    @total_hours_valid_period = 0
    @valid_periods.each do |valid_period|
      start_period = DateTime.strptime(valid_period[:start_period], '%Y-%m-%d')
      end_period = DateTime.strptime(valid_period[:end_period], '%Y-%m-%d')
      hours_valid_period = end_period - start_period
      @total_hours_valid_period = hours_valid_period + @total_hours_valid_period
    end
    @total_hours_valid_period = @total_hours_valid_period*24

    # Categorize Base Rates
    @base_rates_applied_to_payment_scheme = BaseRate.where("(employee_id = ?) AND ((rate_type = 'BASE') OR (rate_type = 'ALLOWANCE')) ", "#{current_employee_id}")
    @base_rates_applied_to_valid_period = BaseRate.where("(employee_id = ?) AND (rate_type = 'OTHER') ", "#{current_employee_id}")
    @base_rates_applied_to_valid_period = @base_rates_applied_to_valid_period.select{ |base_rate|
      conditional = false
      base_start_period = Date.parse(base_rate[:start_of_effectivity].strftime("%Y-%m-%d"))
      base_end_period = Date.parse(base_rate[:end_of_effectivity].strftime("%Y-%m-%d"))
      @valid_periods.each do |valid_period|
        valid_start_period = Date.parse(valid_period[:start_period])
        valid_end_period = Date.parse(valid_period[:end_period])
        conditional = (valid_start_period..valid_end_period).overlaps?(base_start_period..base_end_period)
        if conditional
          break;
        end
      end
      conditional
    }

    @sol = DateTime.parse('2016-11-13 15:31:37')

    render 'human_resources/compensation_and_benefits/payrolls/employee'
  end

  def branch

  end

end
