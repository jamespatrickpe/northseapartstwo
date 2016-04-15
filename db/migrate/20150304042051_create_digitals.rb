class CreateDigitals < MainMigration
  def change
    create_table :digitals, :id => false  do |t|
      common_set_two(t)
      polymorphic_association(t)
      remark(t)
      t.string :url, :limit => 512, :required => true
    end
  end
end
