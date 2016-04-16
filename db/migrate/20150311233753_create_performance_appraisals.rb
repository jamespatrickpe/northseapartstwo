class CreatePerformanceAppraisals < MainMigration
  def change
    create_table :performance_appraisals, :id => false   do |t|
      common_set_one(t)
      employee_id(t)
      t.string :category, :limit => 64
      t.decimal :score, :limit => 16, :precision => 16, :scale => 2, :required => true
    end
    primary_key_override(:performance_appraisals.to_s)
  end
end
