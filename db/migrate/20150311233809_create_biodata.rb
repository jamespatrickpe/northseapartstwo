class CreateBiodata < MainMigration
  def change
    create_table :biodata, :id => false   do |t|
      common_set_two(t)
      t.string :system_account_id, limit: 36,:required => true
      t.string :education, :limit => 256
      t.string :career_experience, :limit => 256
      t.string :notable_accomplishments, :limit => 256
      t.date :date_of_birth
      t.string :family_members, :limit => 256
      t.string :citizenship, :limit => 256
      t.string :gender, :limit => 256
      t.string :place_of_birth, :limit => 256
      t.string :emergency_contact, :limit => 256
      t.string :languages_spoken, :limit => 256
      t.string :complexion, :limit => 256
      t.decimal :height_cm, :limit => 256
      t.string :marital_status, :limit => 256
      t.string :blood_type, :limit => 256
      t.string :religion, :limit => 256
    end
    primary_key_override(:biodata.to_s)
  end
end
