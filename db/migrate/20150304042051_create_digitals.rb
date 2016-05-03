class CreateDigitals < MainMigration
  def change
    create_table :digitals, :id => false  do |t|
      common_set_one(t)
      t.string :contact_detail_id
      t.string :url, :limit => 512, :required => true
    end
    primary_key_override(:digitals.to_s)
  end
end
