class CreateInstitutionalAdjustmentSets < ActiveRecord::Migration
  def change
    create_table :institutional_adjustment_sets, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :employee_id,limit: 36
      t.string :institution_employee_id,limit: 36
      t.string :institutional_adjustment_id,limit: 36
      t.string :institutional_ID, :limit => 512
      t.boolean :activated, :default => true
      t.timestamp
    end
    execute "ALTER TABLE institutional_adjustment_sets ADD PRIMARY KEY (id);"
  end
end
