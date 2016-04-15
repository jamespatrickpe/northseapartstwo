class MainMigration < ActiveRecord::Migration

  def uuid(table)
    table.string :id, :limit => 36, :primary_key => true, null: false
  end

  def remarks(table)
    table.string :remarks, :limit => 256
  end

  def description(table)
    table.string :remarks, :limit => 256
  end

  def employee_id(table)
    table.string :id, :limit => 36
  end

  def actor_id(table)
    table.string :id, :limit => 36
  end

  def time_stamps(table)
    table.timestamps null: false
  end

  def polymorphic_association(table)
    table.string :rel_model_id, limit: 36,:required => true
    table.string :rel_model_type, limit: 36,:required => true
  end

  # Primary Common Pattern for Most Migrations
  def common_set_one(table)
    uuid(table)
    remarks(table)
    time_stamps(table)
  end

  # Secondary Common Pattern for Most Migrations
  def common_set_two(table)
    uuid(table)
    time_stamps(table)
  end

end