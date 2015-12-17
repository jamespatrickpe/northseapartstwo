class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :employee_id, limit: 36,:required => true
      t.datetime :timein
      t.datetime :timeout
      t.string :remark, :limit => 256
      t.timestamps null: false
    end
    execute "ALTER TABLE attendances ADD PRIMARY KEY (id);"
  end
end
