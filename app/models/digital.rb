class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          UrlValidations

  belongs_to :digitable, polymorphic: true

  searchable do

    string :url, :remark
    text :url, :remark
    text :digitable do
      digitable.name
    end

  end

end
