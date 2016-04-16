class CreateTelephones < MainMigration
  def change
    create_table :telephones, :id => false  do |t|
      common_set_two(t)
      polymorphic_association(t)
      remark(t)
      t.string :digits, :limit => 64, :required => true
    end
    primary_key_override(:telephones.to_s)
  end
end
