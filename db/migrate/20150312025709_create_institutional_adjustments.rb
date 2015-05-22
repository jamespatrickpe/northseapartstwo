class CreateInstitutionalAdjustments < ActiveRecord::Migration
  def change
    create_table :institutional_adjustments, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :institution_employee_id, :required => true, limit: 36

      t.decimal :start_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :end_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employer_contribution, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employee_contribution, :limit => 16, :precision => 16, :scale => 2
      t.string :period_of_time, :limit => 64
      t.string :description, :limit => 256

      t.timestamps null: false
    end
  end
end
