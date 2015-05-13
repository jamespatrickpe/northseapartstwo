class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|

      t.belongs_to :employee, :required => true

      t.date :day
      t.time :timein
      t.time :timeout

      t.string :description, :limit => 128

      t.timestamps null: false
    end
  end
end
