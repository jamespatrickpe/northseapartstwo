# Defines a regular work period for a certain employee; e.g. 8-6pm

class CreateRegularWorkPeriods < ActiveRecord::Migration
  def change
    create_table :regular_work_periods, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.time :start
      t.time :end
      t.string :employee_id, limit: 36,:required => true

      t.timestamps null: false
    end
  end
end
