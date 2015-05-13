class CreateAllowableSets < ActiveRecord::Migration
  def change
    create_table :allowable_sets do |t|

      t.belongs_to :access, :required => true

      t.string :security_level, :limit => 64, :required => true
      t.string :controller, :limit => 64, :required => true
      t.string :action, :limit => 64, :required => true

      t.timestamps
    end
  end
end
