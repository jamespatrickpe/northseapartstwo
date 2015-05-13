class CreateLumpAdjustments < ActiveRecord::Migration
  def change
    create_table :lump_adjustments do |t|

      t.belongs_to :employee, :required => true

      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2
      t.string :signed_type, :limit => 64, :'index.html.erb' => true
      t.string :description, :limit => 256

      t.timestamps null: false
    end
  end
end
