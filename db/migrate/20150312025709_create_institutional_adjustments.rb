class CreateInstitutionalAdjustments < MainMigration
  def change
    create_table :institutional_adjustments, :id => false   do |t|
      common_set_one(t)
      period_of_time(t)
      datetime_of_implementation(t)
      t.string :institution, :required => true, limit: 64
      t.string :contribution_type, :required => true, limit: 64, default: "LUMP"
      t.decimal :start_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :end_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employer_contribution, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employee_contribution, :limit => 16, :precision => 16, :scale => 2
    end
    primary_key_override(:institutional_adjustments.to_s)
  end
end


