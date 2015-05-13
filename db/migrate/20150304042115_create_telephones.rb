class CreateTelephones < ActiveRecord::Migration
  def change
    create_table :telephones do |t|

      t.belongs_to :contact_detail, :required => true

      t.string :digits, :limit => 32, :required => true
      t.string :description, :limit => 256

      t.timestamps
    end
  end
end
