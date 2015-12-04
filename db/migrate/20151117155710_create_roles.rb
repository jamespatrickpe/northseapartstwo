class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles , :id => false    do |t|

      t.string :id, limit: 36, primary: true, null: false
      t.string :access_id,limit: 36, :required => true # relates to access because some actors do not have access to the system
      t.string :label, :limit => 256, :required => true # e.g. manager
      t.string :level, :limit => 256, :required => true # e.g. 1..2..3..etc
      t.string :remark, :limit => 256 # some remark set by security personnel/admin

      t.timestamps null: false
    end
  end
end
