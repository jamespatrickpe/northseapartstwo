class CreatePayrollSettings < ActiveRecord::Migration
  def change
    create_table :payroll_settings, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :employee_id, limit: 36,:required => true
      t.string :SSS_ID, limit: 64
      t.string :PHILHEALTH_ID, limit: 64
      t.string :PAGIBIG_ID, limit: 64
      t.string :BIR_ID, limit: 64
      t.boolean :SSS_status, :required => true, default: false
      t.boolean :PHILHEALTH_status, :required => true, default: false
      t.boolean :PAGIBIG_status, :required => true, default: false
      t.boolean :BIR_status, :required => true, default: false
      t.datetime :date_of_effectivity, :required => true, default: Time.now
      t.string :remark, :limit => 256
      t.timestamps
    end
    execute "ALTER TABLE payroll_settings ADD PRIMARY KEY (id);"
  end
end
