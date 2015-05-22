class HumanResourcesController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def candidate_registration
    idSet = Biodatum.pluck(:entity_id)
    @accesses = Access.where.not(id: idSet)
  end

  def registerCandidate
    action_redirect = ""
    id = ""
    ActiveRecord::Base.transaction do
        begin
        processSystemAccount(params)
        processRelatedFiles(params)
        processRelatedLinks(params)

        @biodata = Biodatum.new(
            date_of_birth: params[:biodatum][:birthday],
            height: params[:biodatum][:height],
            family_members: params[:biodatum][:family_members],
            gender: params[:biodatum][:gender],
            complexion: params[:biodatum][:complexion],
            marital_status: params[:biodatum][:marital_status],
            blood_type: params[:biodatum][:blood_type],
            religion: params[:biodatum][:religion],
            education: params[:biodatum][:education],
            career_experience: params[:biodatum][:career_experience],
            notable_accomplishments: params[:biodatum][:notable_accomplishments],
            emergency_contact: params[:biodatum][:emergency_contact],
            languages_spoken: params[:biodatum][:languages_spoken]
        )
        @biodata.entity = @entity
        @biodata.save!

        @employee = Employee.new()
        @employee.entity = @entity
        @employee.save!

        processTemporaryEmail(params)

        action_redirect = "success_candidate_registration"
        id = @access.id
        #action_redirect = "success_candidate_registration?id=" + @access.id

        #Error Processing
        rescue StandardError => e
          flash[:collective_errors] = "An error of type #{e.class} happened, message is #{e.message}"
          action_redirect = "candidate_registration"
      end
    end
    redirect_to action: action_redirect, access_id: id
  end

  def success_candidate_registration
    access_id = params[:access_id]
    @nextLink = {
        0 => {:url => "../home/verification_delivery?access_id=#{access_id}", :label => "Resend Verification"},
        1 => {:url => "candidate_registration", :label => "Add Another Candidate"},
        2 => {:url => "employee_status", :label => "Set Service Status of Employees"}
    }
    @message = "Candidate may start using account if necessary after email verification completes"
    @title = "Candidate Registration Successful"
  end

  def index
    @employees = Employee.all()
  end

  def employee_profile
  end

  def compensation_benefits
    @employees = Employee.all()
  end

  def base_rates
    @employees = Employee.all
    @employee_id = params[:employee_id]
    @base_rates = BaseRate.all.limit(5)

    @defaultNumberOfDays = Constant.find_by(:name => "human_resources.default_duration_of_contract")
  end

  def lump_sum
  end

  def government_inclusions
  end

  def government_inclusions
  end

  def regular_work_period
  end

  def vales
  end

  def payroll_report
  end

  def employee_performance
  end

  def attendance
  end

  def employee_performance
  end




end
