class ContactDetail < ActiveRecord::Base

  def contactable_id
    actor_ids = Actor.all.pluck('id')
    branch_ids = Branch.all.pluck('id')
  end

end
