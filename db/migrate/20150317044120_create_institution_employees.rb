# Description of the Institutions Itself; Defines SSS, Philheath, PAGIBIG

class CreateInstitutionEmployees < ActiveRecord::Migration
  def change
    create_table :institution_employees, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :compensation_type, :limit => 64
      t.string :actor_id, limit: 36, required: true # Needed for Contact Details for Philhealth, Pagibig, etc

      t.timestamps null: false
    end
  end
end

