module HumanResources::CompensationAndBenefits::PayrollsHelper

  def payment_scheme_date(date_aspect, selected_employee, date_of_attendance, current_attendance_date_time)
    render(:partial => 'human_resources/compensation_and_benefits/payrolls/payment_scheme_date', :locals => {:link => link, :id => id})
  end

  def generic_payroll_add_link(link,id)
    render(:partial => 'human_resources/compensation_and_benefits/payrolls/generic_payroll_add_link', :locals => {:link => link, :id => id})
  end

  def generic_payroll_examine_link(link,id)
    render(:partial => 'human_resources/compensation_and_benefits/payrolls/generic_payroll_examine_link', :locals => {:link => link, :id => id})
  end

end
