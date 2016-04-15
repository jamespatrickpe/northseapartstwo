class CreatePayrollSettings < MainMigration
  def change
    create_table :payroll_settings, :id => false  do |t|
      common_set_one(t)
      employee_id(t)
      datetime_of_implementation(t)
      t.string :SSS_ID, limit: 64
      t.string :PHILHEALTH_ID, limit: 64
      t.string :PAGIBIG_ID, limit: 64
      t.string :BIR_ID, limit: 64
      t.boolean :SSS_status, :required => true, default: false
      t.boolean :PHILHEALTH_status, :required => true, default: false
      t.boolean :PAGIBIG_status, :required => true, default: false
      t.boolean :BIR_status, :required => true, default: false
    end
  end
end
