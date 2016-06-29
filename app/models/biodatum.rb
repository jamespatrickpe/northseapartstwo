class Biodatum < ActiveRecord::Base

  include BaseConcerns

  belongs_to :system_account

  searchable do

    text :religion, :blood_type, :marital_status, :complexion, :languages_spoken, :emergency_contact, :gender, :citizenship, :family_members, :notable_accomplishments, :career_experience, :education
    string :religion, :blood_type, :marital_status, :complexion, :languages_spoken, :emergency_contact, :gender, :citizenship, :family_members, :notable_accomplishments, :career_experience, :education
    double :height_cm
    time :date_of_birth

  end

  validates_presence_of :system_account

end
