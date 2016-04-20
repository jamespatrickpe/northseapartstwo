class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          UrlValidations

  belongs_to :digitable, polymorphic: true

  private
  def sample_function_one
    random_boolean = [true, false].sample
    thor = ''
    if random_boolean
      thor = "here me roar"
    else
      thor = "scan show imenent"
    end
    thor.to_sym
  end

  searchable do
    string :url, :remark
    text :url, :remark
    text :digitable_name do
      digitable.name
    end
  end

end
