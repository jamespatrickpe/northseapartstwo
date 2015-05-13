class CreateDigitals < ActiveRecord::Migration
  def change
    create_table :digitals do |t|

      t.belongs_to :contact_detail, :required => true

      t.string :url, :limit => 256, :required => true
      t.string :description, :limit => 256


      t.timestamps
    end
  end
end
