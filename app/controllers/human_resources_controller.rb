class HumanResourcesController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"


  def candidate_registration
    idSet = Biodatum.pluck(:entity_id)
    @accesses = Access.where.not(id: idSet)
  end

  def registerCandidate
    action_redirect = ""
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

        #Error Processing
        action_redirect = "success_candidate_registration"
        rescue StandardError => e
          flash[:collective_errors] = "An error of type #{e.class} happened, message is #{e.message}"
          action_redirect = "candidate_registration"

      end
    end
    redirect_to action: action_redirect
  end

  def success_candidate_registration
    @nextLink = {
        0 => {:url => "resend_verification", :label => "Resend Verification"},
        1 => {:url => "candidate_registration", :label => "Add Another Candidate"},
        2 => {:url => "candidate_status", :label => "Re-Assignment of Employee Employees"},
        3 => {:url => "candidate_status", :label => "Re-Assignment of Employee Employees"}
    }
    @message = "Candidate may start using account if necessary after email verification completes"
    @title = "Candidate Registration Successful"
  end

  def resend_verification

  end

end
