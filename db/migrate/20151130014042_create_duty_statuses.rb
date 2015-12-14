class CreateDutyStatuses < ActiveRecord::Migration
  def change
    create_table :duty_statuses, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :remark, :limit => 256
      t.boolean :active, :required => true, default: false
      t.string :employee_id,limit: 36, :required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE duty_statuses ADD PRIMARY KEY (id);"
  end
end
