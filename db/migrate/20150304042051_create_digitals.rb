class CreateDigitals < MainMigration
  def change
    create_table :digitals, :id => false  do |t|
      common_set_two(t)
      remark(t)
      t.string :digitable_id
      t.string :digitable_type
      t.string :url, :limit => 512, :required => true
    end
    primary_key_override(:digitals.to_s)
  end
end
