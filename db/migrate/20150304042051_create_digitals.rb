class CreateDigitals < ActiveRecord::Migration
  def change
    create_table :digitals do |t|

      t.string :url, :limit => 512
      t.string :description, :limit => 512
      t.belongs_to :contact_detail

      t.timestamps
    end
  end
end
