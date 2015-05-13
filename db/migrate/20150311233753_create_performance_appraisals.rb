class CreatePerformanceAppraisals < ActiveRecord::Migration
  def change
    create_table :performance_appraisals do |t|

      t.belongs_to :employee, :required => true
      t.string :description, :limit => 256
      t.string :category, :limit => 64
      t.decimal :score, :limit => 16, :precision => 16, :scale => 2, :required => true

      t.timestamps null: false
    end
  end
end
