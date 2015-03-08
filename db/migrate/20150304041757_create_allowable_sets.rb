class CreateAllowableSets < ActiveRecord::Migration
  def change
    create_table :allowable_sets do |t|
      t.string :security_level, :limit => 128
      t.string :controller, :limit => 128
      t.string :action, :limit => 128

      t.timestamps
    end
  end
end
