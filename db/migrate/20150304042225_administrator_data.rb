class AdministratorData < ActiveRecord::Migration
  def change

    myEntity = Entity.create(name: "James Patrick Pe", description: "Administrator")
    myEntity.save

    access = Access.create( username: 'joojieman', password: 'Nothing1!', remember_me: 'true', security_level: 'ADMIN', password_confirmation: 'Nothing1!')
    access.entity = myEntity
    access.save

  end
end
