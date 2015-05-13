class CreateInstitutionEmployees < ActiveRecord::Migration
  def change
    create_table :institution_employees do |t|

      t.belongs_to :entity
      t.string :compensation_type

      t.timestamps null: false
    end
  end
end
