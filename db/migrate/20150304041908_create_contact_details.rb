class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36, :required => true
      t.timestamps
    end
    execute "ALTER TABLE contact_details ADD PRIMARY KEY (id);"
  end
end
