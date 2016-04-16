class CreateValeAdjustments < MainMigration
  def change
    create_table :vale_adjustments, :id => false do |t|
      common_set_one(t)
      amount(t)
      datetime_of_implementation(t)
      t.string :vale_id, limit: 36,:required => true
    end
    primary_key_override(:vale_adjustments.to_s)
  end
end
