class CreateRegularWorkPeriods < ActiveRecord::Migration
  def change
    create_table :regular_work_periods do |t|

      t.timestamps null: false
    end
  end
end
