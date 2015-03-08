class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
      t.belongs_to :entity
      t.timestamps
    end
  end
end
