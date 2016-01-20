class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :employee_id, limit: 36,:required => true
      t.string :type_of_leave, :limit => 64
      t.datetime :start_of_effectivity, default: Time.now
      t.datetime :end_of_effectivity, default: Time.now
      t.string :remark, :limit => 256
      t.timestamps null: false
    end
    execute "ALTER TABLE leaves ADD PRIMARY KEY (id);"
  end
end