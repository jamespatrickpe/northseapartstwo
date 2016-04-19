class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          UrlValidations

  belongs_to :digitable, polymorphic: true

  searchable do
    string :url
    text :url

    string :digitable_type
    text :digitable_type

    string :digitable_id
    text :digitable_id

    string :remark
    text :remark
  end

end
