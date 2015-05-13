class CreateInstitutionalAdjustments < ActiveRecord::Migration
  def change
    create_table :institutional_adjustments do |t|

      t.belongs_to :institution_employee, :required => true

      t.decimal :start_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :end_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employer_contribution, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employee_contribution, :limit => 16, :precision => 16, :scale => 2
      t.string :period_of_time, :limit => 16
      t.string :description, :limit => 256

      t.timestamps null: false
    end
  end
end
