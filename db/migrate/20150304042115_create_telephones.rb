class CreateTelephones < ActiveRecord::Migration
  def change
    create_table :telephones do |t|

      t.string :digits, :limit => 32
      t.string :description, :limit => 512
      t.belongs_to :contact_detail

      t.timestamps
    end
  end
end
