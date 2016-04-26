class Digital < ActiveRecord::Base

  include BaseConcerns,
          Remark,
          Url

  belongs_to :digitable, polymorphic: true

  searchable do
    text :digitable do
      digitable.try(:name)
    end
  end

end
