class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          UrlValidations

  belongs_to :digitable, polymorphic: true

  searchable do
    text :id
    string :url
    text :digitable_type
    text :digitable_id
    text :remark
    time :created_at
    time :updated_at
  end

end
