# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include ApplicationHelper

#ENTITIES
numberOfEntities = 50
numberOfEntities.times do |i|
  #Entity
  myEntity = Entity.create(name: Faker::Name.name , description: Faker::Lorem.sentence(3, true), logo: 'sample.jpg')
  myEntity.save

  #Access
  randomPassword = Faker::Internet.password(10, 20)
  random_boolean = [true, false].sample
  myAccess = Access.create( username: Faker::Internet.user_name, password: randomPassword, remember_me: random_boolean, security_level: 'NONE', password_confirmation: randomPassword )
  myAccess.entity = myEntity
  myAccess.save

  #Verification
  myVerification = Verification.create( temp_email: Faker::Internet.email, hashlink: generateRandomString(), verified: 0 )
  myVerification.access = myAccess
  myVerification.save

  #ContactDetail
  myContactDetail = ContactDetail.create()
  myContactDetail.entity = myEntity
  randomNumberOfAddresses = rand(0..5)
  randomNumberOfTelephony = rand(0..5)
  randomNumberOfDigital = rand(0..5)

  #Addresses
  randomNumberOfAddresses.times do |i|
    completeAddress = Faker::Address.building_number + Faker::Address.street_name + Faker::Address.street_address + Faker::Address.city + Faker::Address.country
    myAddress = Address.create( description: completeAddress, longitude: Faker::Address.longitude, latitude: Faker::Address.latitude )
    myAddress.contact_detail = myContactDetail
    myAddress.save
  end

  #Telephony
  randomNumberOfTelephony.times do |i|
    myTelephony = Telephone.new( description: Faker::Lorem.sentences(1), digits: Faker::PhoneNumber.phone_number )
    myTelephony.contact_detail = myContactDetail
    myTelephony.save
  end

  #Digital
  randomNumberOfDigital.times do |i|
    myDigital = Digital.new( description: Faker::Lorem.sentences(1), url: Faker::Internet.url )
    myDigital.contact_detail = myContactDetail
    myDigital.save
  end
end