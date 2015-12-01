class HumanResourcesController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def index
    render 'human_resources/index'
  end

  def employee_accounts_management

    @duties = Duty.all()

    # native fetch-all
    # @employees = Employee.all()

    if params[:search_employee]

      # create an empty employee array, then find all actor that has the name that was searched
      # iterate through all the result actors and find their corresponding employee object
      # push that employee object into the empty array for display and then lastly, paginate using Kaminari

      @employees = []
      @actorsFound= Actor.where("name LIKE ?", "%#{params[:search_employee]}%")

      @actorsFound.each { |actor|
        emp = Employee.find_by_actor_id(actor.id)
        @employees.push(emp)
      }

      # kaminari pager
      @employees = Kaminari.paginate_array(@employees).page(params[:page]).per(10)

    else

      # get all employees by default
      @employees = Employee.page(params[:page]).per(10)

    end

    render 'human_resources/employee_accounts_management/index'
  end

  def employee_account_history

    # @duties = Duty.where( employee_id: params[:employee][:employee_id] )
    render 'human_resources/employee_accounts_management/employee_account_history'
  end

  def employee_registration
    render 'human_resources/employee_accounts_management/employee_registration'
  end

  def employee_profile

    @employee = Employee.find(params[:employee_id])
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])

    render 'human_resources/employee_accounts_management/employee_profile'
  end

  def attendance
    render 'human_resources/attendance/index'
  end

  def branch_attendance_sheet
    render 'human_resources/attendance/branch_attendance_sheet'
  end

  def employee_attendance_history
    render 'human_resources/attendance/employee_attendance_history'
  end

  def settings
    @constants = Constant.where( 'name ILIKE ?', "%human_resources%" )
    render 'human_resources/settings/index'
  end

  def holidays
    @holidays = Holiday.all()
    @holiday_types = HolidayType.all()
    render 'human_resources/settings/holidays'
  end

  def institutional_adjustments
    @institutionalAdjustment = InstitutionalAdjustment.all()
    @institutionEmployee = InstitutionEmployee.all()

    render 'human_resources/settings/institutional_adjustments'
  end

  def compensation_benefits
    render 'human_resources/compensation_benefits/index'
  end

  def advanced_payments
    @advancedPaymentsToEmployee = AdvancedPaymentsToEmployee.all()
    render 'human_resources/compensation_benefits/advanced_payments'
  end

  def repayments_to_advance_payments
    @advancedPaymentsToEmployee = AdvancedPaymentsToEmployee.all()
    render 'human_resources/compensation_benefits/repayments_to_advance_payments'
  end

  def decision_on_advance_payments
    @advancedPaymentsToEmployee = AdvancedPaymentsToEmployee.all()
    render 'human_resources/compensation_benefits/decision_on_advance_payments'
  end

  def employee_payroll_history(params)

    render 'human_resources/compensation_benefits/employee_payroll_history'
  end

  def printable_format
    render 'human_resources/compensation_benefits/printable_format'
  end

  def lump_adjustments
    @lumpAdjustment = LumpAdjustment.all()
    render 'human_resources/compensation_benefits/lump_adjustments'
  end

  def rest_days
    @restdays = Restday.all()
    render 'human_resources/compensation_benefits/rest_days'
  end

  def regular_work_periods
    @regularWorkPeriods = RegularWorkPeriod.all()
    render 'human_resources/compensation_benefits/regular_work_periods'
  end

  def edit_employee_page

    puts params[:employee_id]
    puts params[:actor_id]

    @employee = Employee.find(params[:employee_id])
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])

    render 'human_resources/employee_accounts_management/edit_employee_profile'
  end

  def edit_employee_data

    # find existing employee and biodata using the id from the params
    @employee = Employee.find(params[:employee_id])
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])

    # the actual update method passing the parameters set from the pagee
    @biodatum.update_attributes(biodata_params)
    @employee.update_attributes(employee_params)

    # find the existing actor
    actor = Actor.find(params[:actor_id])

    # update the concerned attributes of the actor and assign it back to the objects
    actor.update_attributes(actor_params)

    @employee.actor = actor
    @biodatum.actor = actor

    @biodatum.save!

    if @employee.save && @biodatum.save
      @success_message = 'Successfully edited employee details for ' + @employee.actor.name + '.'
      # render 'human_resources/employee_accounts_management/edit_employee_profile'
      render 'core_partials/employee_registration_success'
    else
      puts 'failed'
      render 'human_resources/employee_accounts_management/edit_employee_profile'
    end

  end

  def delete_employee
    @employees = Employee.all()
    employee = Employee.find(params[:employee_id])
    employee.destroy
    render 'human_resources/employee_accounts_management/index'

  end

  def register_employee

    actor = Actor.new(actor_params)
    @employee = Employee.new
    @biodata = Biodatum.new(biodata_params)
    @employee.actor = actor
    @biodata.actor = actor

    @biodata.save!
    @employee.save!

    if @employee.save!

      # Message Constants
      @success_message = 'Successfully registered new employee, ' + @employee.actor.name + '.'

      render 'core_partials/employee_registration_success'

    else

      render 'human_resources/employee_accounts_management/employee_registration'

    end

  end

  private

  def actor_params
    params.require(:actor).permit(:name, :description)
  end

  def employee_params
    params.require(:actor).permit(:actor_id)
  end

  def biodata_params
    params.require(:biodatum)
        .permit(
            :date_of_birth,
            :height,
            :family_members,
            :gender,
            :complexion,
            :marital_status,
            :blood_type,
            :religion,
            :education,
            :career_experience,
            :notable_accomplishments,
            :emergency_contact,
            :languages_spoken
        )
  end


##################################3


# OLD CODE; PLEASE USE AS REFERENCE

# def candidate_registration
#   idSet = Biodatum.pluck(:actor_id)
#   @accesses = Access.where.not(id: idSet)
# end
#
# def registerCandidate
#   action_redirect = ""
#   id = ""
#   ActiveRecord::Base.transaction do
#       begin
#       processSystemAccount(params)
#       processRelatedFiles(params)
#       processRelatedLinks(params)
#
#       @biodata = Biodatum.new(
#           date_of_birth: params[:biodatum][:birthday],
#           height: params[:biodatum][:height],
#           family_members: params[:biodatum][:family_members],
#           gender: params[:biodatum][:gender],
#           complexion: params[:biodatum][:complexion],
#           marital_status: params[:biodatum][:marital_status],
#           blood_type: params[:biodatum][:blood_type],
#           religion: params[:biodatum][:religion],
#           education: params[:biodatum][:education],
#           career_experience: params[:biodatum][:career_experience],
#           notable_accomplishments: params[:biodatum][:notable_accomplishments],
#           emergency_contact: params[:biodatum][:emergency_contact],
#           languages_spoken: params[:biodatum][:languages_spoken]
#       )
#       @biodata.actor = @actor
#       @biodata.save!
#
#       @employee = Employee.new()
#       @employee.actor = @actor
#       @employee.save!
#
#       processTemporaryEmail(params)
#     end
#   end
# end
#
# def success_candidate_registration
#   access_id = params[:access_id]
#   @nextLink = {
#       0 => {:url => "../home/verification_delivery?access_id=#{access_id}", :label => "Resend Verification"},
#       1 => {:url => "candidate_registration", :label => "Add Another Candidate"},
#       2 => {:url => "employee_status", :label => "Set Service Status of Employees"}
#   }
#   @message = "Candidate may start using account if necessary after email verification completes"
#   @title = "Candidate Registration Successful"
# end
#
# def index
#   @employees = Employee.all()
# end
#
# def employee_profile
# end
#
# def compensation_benefits
#   @employees = Employee.all()
# end
#
# def base_rates
#   getEmployees();
#   @base_rates = BaseRate.where(employee_id: @employee_id)
# end
#
# def lump_adjustments
#   getEmployees();
#   @lump_adjustments = LumpAdjustment.where(employee_id: @employee_id)
# end
#
# def deleteBaseRate
#   baseRateID = params[:base_rate_id]
#   employee_id = params[:employee_id]
#   BaseRate.find(baseRateID).destroy
#   redirect_to  :action => "base_rates", :employee_id => employee_id
# end
#
# def addNewBaseRate
#   action_redirect = "base_rates"
#   employee_id = params[:employee_id]
#
#   ActiveRecord::Base.transaction do
#     begin
#       signed_type = params[:signed_type]
#       amount = params[:amount]
#       period_of_time = params[:period_of_time]
#       start_of_effectivity = DateTime.parse(params[:start_of_effectivity].to_s).strftime("%Y/%m/%d %H:%M:%S")
#       end_of_effectivity = DateTime.parse(params[:end_of_effectivity].to_s).strftime("%Y/%m/%d %H:%M:%S")
#       description = params[:description]
#       if(BaseRate.exists?(params[:base_rate_id]))
#         currentBaseRate = BaseRate.find_by(id: params[:base_rate_id])
#         currentBaseRate.update(signed_type:signed_type, amount:amount, period_of_time:period_of_time, start_of_effectivity:start_of_effectivity, end_of_effectivity:end_of_effectivity,description:description)
#       else
#         currentBaseRate = BaseRate.new(description:description, employee_id:employee_id, signed_type:signed_type, amount:amount, period_of_time:period_of_time, start_of_effectivity:start_of_effectivity, end_of_effectivity:end_of_effectivity )
#         currentBaseRate.save!
#       end
#       flash[:collective_responses] = "Entry Successful!"
#     rescue StandardError => e
#       flash[:collective_responses] = "An error of type #{e.class} happened, message is #{e.message}"
#     end
#   end
#   redirect_to  :action => action_redirect, :employee_id => employee_id
# end
#
# def addLumpAdjustment
#   action_redirect = "lump_adjustments"
#   employee_id = params[:employee_id]
#
#   ActiveRecord::Base.transaction do
#     begin
#       signed_type = params[:signed_type]
#       amount = params[:amount]
#       date_of_effectivity = DateTime.parse(params[:date_of_effectivity].to_s).strftime("%Y/%m/%d %H:%M:%S")
#       description = params[:description]
#       if(LumpAdjustment.exists?(params[:lump_adjustment_id]))
#         currentLumpAdjustment = LumpAdjustment.find_by(id: params[:lump_adjustment_id])
#         currentLumpAdjustment.update(employee_id:employee_id, signed_type:signed_type, amount:amount, date_of_effectivity:date_of_effectivity,description:description)
#       else
#         currentLumpAdjustment = LumpAdjustment.new(description:description, employee_id:employee_id, signed_type:signed_type, amount:amount, date_of_effectivity:date_of_effectivity, )
#         currentLumpAdjustment.save!
#       end
#       flash[:collective_responses] = "Entry Successful!"
#     rescue StandardError => e
#       flash[:collective_responses] = "An error of type #{e.class} happened, message is #{e.message}"
#     end
#   end
#   redirect_to  :action => action_redirect, :employee_id => employee_id
# end
#
# def deleteLumpAdjustment
#   lumpAdjustmentID = params[:lump_adjustment_id]
#   employee_id = params[:employee_id]
#   LumpAdjustment.find(lumpAdjustmentID).destroy
#   redirect_to  :action => "lump_adjustments", :employee_id => employee_id
# end

end
