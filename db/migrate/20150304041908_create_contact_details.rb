class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false

      t.string :entity_id, limit: 36, :required => true

      t.timestamps
    end
  end
end
