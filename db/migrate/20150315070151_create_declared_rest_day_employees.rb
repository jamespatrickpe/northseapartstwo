class CreateDeclaredRestDayEmployees < ActiveRecord::Migration
  def change
    create_table :declared_rest_day_employees do |t|

      t.belongs_to :employee, :required => true

      t.string :day, :limit => 64, :required => true

      t.timestamps null: false
    end
  end
end
