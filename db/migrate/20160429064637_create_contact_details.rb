class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details, :id => false  do |t|
      common_set_one(t)
      t.string :contactable_id
      t.string :contactable_type
    end
    primary_key_override(:contact_details.to_s)
  end
end
