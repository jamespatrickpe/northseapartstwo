class ContactDetail < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :contactable, polymorhic: true


end