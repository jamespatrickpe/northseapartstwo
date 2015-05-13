class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|

      t.belongs_to :entity, :required => true
      t.timestamps null: false
    end
  end
end
