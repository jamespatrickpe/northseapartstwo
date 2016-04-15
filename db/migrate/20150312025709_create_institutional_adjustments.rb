class CreateInstitutionalAdjustments < MainMigration
  def change
    create_table :institutional_adjustments, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :institution, :required => true, limit: 64
      t.string :contribution_type, :required => true, limit: 64, default: "LUMP"
      t.decimal :start_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :end_range, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employer_contribution, :limit => 16, :precision => 16, :scale => 2
      t.decimal :employee_contribution, :limit => 16, :precision => 16, :scale => 2
      t.string :period_of_time, :limit => 64
      t.string :description, :limit => 256
      t.datetime :date_of_effectivity, :required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE institutional_adjustments ADD PRIMARY KEY (id);"
  end
end


