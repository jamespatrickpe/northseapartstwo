class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|

      t.belongs_to :holiday_type

      t.date :date_of_implementation, :required => true
      t.string :description, :limit => 256
      t.string :name, :limit => 64

      t.timestamps null: false
    end
  end
end
