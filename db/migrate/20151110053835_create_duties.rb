class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties , :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :description, :limit => 256
      t.string :label, :limit => 64
      t.string :employee_id,limit: 36, :required => true

      t.timestamps null: false
    end
  end
end
