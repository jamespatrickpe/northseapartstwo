class CreateInstitutionalAdjustmentSets < ActiveRecord::Migration
  def change
    create_table :institutional_adjustment_sets do |t|

      t.belongs_to :employee
      t.belongs_to :institution_employee
      t.belongs_to :institutional_adjustment

      t.string :institutional_ID
      t.boolean :activated, :default => true

      t.timestamp
    end
  end
end
