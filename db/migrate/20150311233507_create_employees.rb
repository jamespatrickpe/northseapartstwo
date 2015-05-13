class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|

      t.belongs_to :entity, :required => true
      t.string :status, :limit => 64
      t.string :rest_day, :limit => 64, :required => true

      t.timestamps null: false
    end
  end
end
