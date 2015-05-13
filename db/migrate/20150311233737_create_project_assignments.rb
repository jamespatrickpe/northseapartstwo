class CreateProjectAssignments < ActiveRecord::Migration
  def change
    create_table :project_assignments do |t|

      t.belongs_to :employee, :required => true
      t.belongs_to :Branch, :required => true

      t.string :department, :limit => 64
      t.string :position, :limit => 64
      t.string :task, :limit => 64
      t.datetime :duration_start
      t.datetime :duration_finish

      t.timestamps null: false
    end
  end
end
