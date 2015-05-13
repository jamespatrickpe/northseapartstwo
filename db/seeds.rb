# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include ApplicationHelper

#  ----------------------------------------------------------------------------------- OFFICIAL STARTER DATA ------------------------------------------------------------------------

#Administrator
myEntity = Entity.create(name: 'James Patrick Pe', description: 'Administrator')
myEntity.save

access = Access.create( username: 'joojieman', password: 'Nothing1!', remember_me: 1, password_confirmation: 'Nothing1!')
access.entity = myEntity
access.save

allowableSet = AllowableSet.create( security_level: 'ADMIN', controller: 'ALL', action: 'ALL')
allowableSet.access = access
allowableSet.save

#HUMAN RESOURCES

#Holiday
regularHoliday = HolidayType.create( type_name: "Regular Holiday", additional_rate: 2.00, additional_rate_overtime: 1.30, additional_rate_rest_day_priveleges: 1.3, no_work_pay: true)
specialNonWorkingHoliday = HolidayType.create( type_name: "Special Non Working Holiday", additional_rate: 1.3, additional_rate_overtime: 1.30, additional_rate_rest_day_priveleges: 1.5, no_work_pay: false)

Holiday.create( date_of_implementation: Date.new(2016,1,1) , name: "New Year's Day", holiday_type: regularHoliday)
Holiday.create( date_of_implementation: Date.new(2016,2,8) , name: "Chinese Lunar New Year's Day", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2016,3,24) , name: "Maundy Thursday", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,3,25) , name: "Good Friday", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,4,9) , name: "The Day of Valor", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,5,1) , name: "Labor Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,6,12) , name: "Ninoy Aquino Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,8,21) , name: "National Heroes Day", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2016,8,28) , name: "National Heroes Day holiday", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,11,1) , name: "All Saints' Day", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2016,12,25) , name: "Christmas Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,12,30) , name: "Rizal Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2016,12,31) , name: "New Year's Eve", holiday_type: specialNonWorkingHoliday )

Holiday.create( date_of_implementation: Date.new(2015,1,1) , name: "New Year's Day", holiday_type: regularHoliday)
Holiday.create( date_of_implementation: Date.new(2015,1,2) , name: "Special non-working day after New Year", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2015,2,19) , name: "Chinese Lunar New Year's Day", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2015,4,2) , name: "Maundy Thursday", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,4,3) , name: "Good Friday", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,4,4) , name: "Holy Saturday", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2015,4,9) , name: "The Day of Valor", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,5,1) , name: "Labor Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,5,12) , name: "Independence Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,8,21) , name: "Ninoy Aquino Day", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2015,8,30) , name: "National Heroes Day", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2015,8,31) , name: "National Heroes Day Holiday", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,11,1) , name: "All Saints' Day", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2015,11,30) , name: "Bonifacio Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,12,24) , name: "Christmas Eve", holiday_type: specialNonWorkingHoliday )
Holiday.create( date_of_implementation: Date.new(2015,12,25) , name: "Christmas Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,12,30) , name: "Rizal Day", holiday_type: regularHoliday )
Holiday.create( date_of_implementation: Date.new(2015,12,31) , name: "New Year's Eve", holiday_type: specialNonWorkingHoliday )

#Institutional Adjustment

# Employee Institutions
sss = Entity.create(name: "SSS" , description: "SSS", logo: 'sample.jpg')
philhealth = Entity.create(name: "Philhealth" , description: "Philhealth", logo: 'sample.jpg')
pagibig = Entity.create(name: "Pagibig" , description: "Pagibig", logo: 'sample.jpg')

mySSS = InstitutionEmployee.create( entity: sss, compensation_type: "LUMP")
myPhilhealth = InstitutionEmployee.create( entity: philhealth, compensation_type: "LUMP")
myPagibig = InstitutionEmployee.create( entity: pagibig, compensation_type: "PERCENTAGE")

InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 1000, end_range: 1249.99, employer_contribution: 83.7, employee_contribution: 36.3, period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 1250, end_range: 1749.99, employer_contribution: 120.5, employee_contribution: 54.5, period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 1750, end_range: 2249.99, employer_contribution: 157.3, employee_contribution: 72.7, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 2250, end_range: 2749.99, employer_contribution: 194.20, employee_contribution: 90.8, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 2750, end_range: 3249.99, employer_contribution: 231.00, employee_contribution: 109.00, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 3250, end_range: 3749.99, employer_contribution: 267.80, employee_contribution: 127.20, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 3750, end_range: 4249.99, employer_contribution: 304.7, employee_contribution: 145.3, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 4250, end_range: 4749.99, employer_contribution: 341.5, employee_contribution: 163.5, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 4750, end_range: 5249.99, employer_contribution: 378.3, employee_contribution: 181.7, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 5250, end_range: 5749.99, employer_contribution: 415.20, employee_contribution: 199.8, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 5750, end_range: 6249.99, employer_contribution: 452.00, employee_contribution: 218.00, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 6250, end_range: 6749.99, employer_contribution: 488.8, employee_contribution: 236.2, period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 6250, end_range: 7249.99, employer_contribution: 525.7, employee_contribution: 254.30, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 7250, end_range: 7749.99, employer_contribution: 562.5, employee_contribution: 272.5, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 7750, end_range: 8249.99, employer_contribution: 599.3, employee_contribution: 290.7, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 8250, end_range: 8749.99, employer_contribution: 636.20, employee_contribution: 308.8, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 8750, end_range: 9249.99, employer_contribution: 673.00, employee_contribution: 327.00, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 9250, end_range: 9749.99, employer_contribution: 709.80, employee_contribution: 345.20, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 9750, end_range: 10249.99, employer_contribution: 746.70, employee_contribution: 363.3, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 10250, end_range: 10749.99, employer_contribution: 783.50, employee_contribution: 381.5, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 10750, end_range: 11249.99, employer_contribution: 820.30, employee_contribution: 399.7, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 11250, end_range: 11749.99, employer_contribution: 857.20, employee_contribution: 417.8, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 11750, end_range: 12249.99, employer_contribution: 894.00, employee_contribution: 436.00, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 12250, end_range: 12749.99, employer_contribution: 930.80, employee_contribution: 454.2, period_of_time: "WEEK"   )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 12750, end_range: 13249.99, employer_contribution: 967.70, employee_contribution: 472.3 , period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 13250, end_range: 13749.99, employer_contribution: 1004.50, employee_contribution: 490.50 , period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 13750, end_range: 14249.99, employer_contribution: 1041.30, employee_contribution: 508.70 , period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 14250, end_range: 14749.99, employer_contribution: 1078.20, employee_contribution: 526.8 , period_of_time: "WEEK" )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 14750, end_range: 15249.99, employer_contribution: 1135.00, employee_contribution: 545.00 , period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 15250, end_range: 15749.99, employer_contribution: 1171.80, employee_contribution: 563.20 , period_of_time: "WEEK"  )
InstitutionalAdjustment.create( institution_employee: mySSS, start_range: 15750, end_range: 99999999999.99, employer_contribution: 1208.70, employee_contribution: 581.30 , period_of_time: "WEEK"  )

InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 0.00, end_range: 8999.99, employer_contribution: 100.0, employee_contribution: 100.0 , period_of_time: "MONTH"  )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 9000.00 , end_range: 9999.99, employer_contribution: 112.5, employee_contribution: 112.5 , period_of_time: "MONTH")
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 10000.00 , end_range: 10999.99, employer_contribution: 125.00, employee_contribution: 125.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 11000.00 , end_range: 11999.99, employer_contribution: 137.50, employee_contribution: 137.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 12000.00, end_range: 12999.99, employer_contribution: 150.00, employee_contribution: 150.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 13000.00, end_range: 13999.99, employer_contribution: 162.50, employee_contribution: 162.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 14000.00, end_range: 14999.99, employer_contribution: 175.00, employee_contribution: 175.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 15000.00, end_range: 15999.99, employer_contribution: 187.50, employee_contribution: 187.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 16000.00, end_range: 16999.99, employer_contribution: 200.00, employee_contribution: 200.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 17000.00, end_range: 17999.99, employer_contribution: 212.50, employee_contribution: 212.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 18000.00, end_range: 18999.99, employer_contribution: 225.00, employee_contribution: 225.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 19000.00, end_range: 19999.99, employer_contribution: 237.50, employee_contribution: 237.50, period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 20000.00, end_range: 20999.99, employer_contribution: 250.00, employee_contribution: 250.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 21000.00, end_range: 21999.99, employer_contribution: 262.50, employee_contribution: 262.50  , period_of_time: "MONTH")
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 22000.00, end_range: 22999.99, employer_contribution: 275.00, employee_contribution: 275.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 23000.00, end_range: 23999.99, employer_contribution: 287.50, employee_contribution: 287.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 24000.00, end_range: 24999.99, employer_contribution: 300.00, employee_contribution: 300.00, period_of_time: "MONTH"  )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 25000.00, end_range: 25999.99, employer_contribution: 312.50, employee_contribution: 312.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 26000.00, end_range: 26999.99, employer_contribution: 325.00, employee_contribution: 325.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 27000.00, end_range: 27999.99, employer_contribution: 337.50, employee_contribution: 337.50, period_of_time: "MONTH"  )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 28000.00, end_range: 28999.99, employer_contribution: 350.00, employee_contribution: 350.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 29000.00, end_range: 29999.99, employer_contribution: 362.50, employee_contribution: 362.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 30000.00, end_range: 30999.99, employer_contribution: 375.00, employee_contribution: 375.00, period_of_time: "MONTH"  )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 31000.00, end_range: 31999.99, employer_contribution: 387.50, employee_contribution: 387.50, period_of_time: "MONTH"  )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 32000.00, end_range: 32999.99, employer_contribution: 400.00, employee_contribution: 400.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 33000.00, end_range: 33999.99, employer_contribution: 412.50, employee_contribution: 412.50 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 34000.00, end_range: 34999.99, employer_contribution: 425.00, employee_contribution: 425.00 , period_of_time: "MONTH" )
InstitutionalAdjustment.create( institution_employee: myPhilhealth, start_range: 35000.00, end_range: 99999999999.99, employer_contribution: 437.50, employee_contribution:  437.50 , period_of_time: "MONTH")

InstitutionalAdjustment.create( institution_employee: myPagibig, start_range: 0.00, end_range: 99999999999.99, employer_contribution: 100.00, employee_contribution:  100.00 , period_of_time: "MONTH")

# Branches
northseaone = Entity.create(name: "North Sea Parts One" , description: "Original North Sea Parts Base", logo: 'sample.jpg')
amppidiesel = Entity.create(name: "Ampid Diesel Trading" , description: "Ampid Diesel Trading", logo: 'sample.jpg')
stockhouse = Entity.create(name: "North Sea Stock House" , description: "Stockhouse", logo: 'sample.jpg')

cd_northseaone = ContactDetail.create( entity: northseaone)
  Address.create( description: "North Sea Parts, Marcos Highway, Cainta, Rizal", longitude: "14.6058853", latitude: "121.1292978", contact_detail: cd_northseaone  )
  Telephone.create( description: "Telephone Number 1", digits: "6451514", contact_detail: cd_northseaone  )
  Telephone.create( description: "Telephone Number 2", digits: "6452237", contact_detail: cd_northseaone  )
  Digital.create( description: "Email 1", url: "northseaparts@yahoo.com", contact_detail: cd_northseaone )
  Digital.create( description: "Email 2", url: "northseaparts@gmail.com", contact_detail: cd_northseaone )

cd_ampidiesel = ContactDetail.create( entity: amppidiesel)
  Address.create( description: "Ampid Diesel Trading, General Luna Avenue, San Mateo, Rizal", longitude: "14.698516", latitude: "121.121944", contact_detail: cd_ampidiesel  )
  Telephone.create( description: "Telephone Number 1", digits: "9489991", contact_detail: cd_ampidiesel  )

cd_stockhouse = ContactDetail.create( entity: stockhouse)
  Address.create( description: "North Sea Stockhouse, Sumulong Highway, Antipolo, Rizal", longitude: "14.6171302", latitude: "121.1340643", contact_detail: cd_stockhouse  )

b1 = Branch.create( entity: northseaone )
b2 = Branch.create( entity: amppidiesel )
b3 = Branch.create( entity: stockhouse )



#  ----------------------------------------------------------------------------------- RANDOM SEED DATA ------------------------------------------------------------------------

def randomBoolean()
  return [true, false].sample
end

def randomMoney( lower, upper)
  return rand(lower..upper)
end

#ENTITIES
numberOfEntities = 200
numberOfEntities.times do |i|
  #Entity
  myEntity = Entity.new(name: Faker::Name.name , description: Faker::Lorem.sentence(3, true), logo: 'sample.jpg')
  myEntity.save

  # ACCESS
  if (randomBoolean())
    #Access
    randomPassword = Faker::Internet.password(10, 20)
    random_boolean = [true, false].sample
    myAccess = Access.new( username: Faker::Internet.user_name, password: randomPassword, remember_me: random_boolean, password_confirmation: randomPassword, entity: myEntity )
    myAccess.save

    #Verification
    myVerification = Verification.new( temp_email: Faker::Internet.email, hashlink: generateRandomString(), verified: randomBoolean, access: myAccess)
    myVerification.save

    #ContactDetail
    myContactDetail = ContactDetail.create( entity: myEntity)
    randomNumberOfAddresses = rand(0..5)
    randomNumberOfTelephony = rand(0..5)
    randomNumberOfDigital = rand(0..5)

    #Addresses
    randomNumberOfAddresses.times do |i|
      completeAddress = Faker::Address.building_number + Faker::Address.street_name + Faker::Address.street_address + Faker::Address.city + Faker::Address.country
      myAddress = Address.new( description: completeAddress, longitude: Faker::Address.longitude, latitude: Faker::Address.latitude, contact_detail: myContactDetail  )
      myAddress.save
    end

    #Telephony
    randomNumberOfTelephony.times do |i|
      myTelephony = Telephone.new( description: Faker::Lorem.sentences(1), digits: Faker::PhoneNumber.phone_number, contact_detail: myContactDetail  )
      myTelephony.save
    end

    #Digital
    randomNumberOfDigital.times do |i|
      myDigital = Digital.new( description: Faker::Lorem.sentences(1), url: Faker::Internet.url, contact_detail: myContactDetail )
      myDigital.save
    end
  end

  # BIODATA
  if(randomBoolean())
    myBioData = Biodatum.new()
    myBioData.entity = myEntity
    myBioData.education = Faker::Company.name
    myBioData.career_experience = Faker::Lorem.words(4)
    myBioData.notable_accomplishments = Faker::Lorem.sentence(3, false, 4)
    myBioData.date_of_birth = Faker::Date.between(600.months.ago, 216.months.ago)
    myBioData.family_members = Faker::Lorem.sentence(3, false, 4)
    myBioData.citizenship = Faker::Address.country
    myBioData.gender = ["male", "female"].sample
    myBioData.place_of_birth = Faker::Address.city
    myBioData.emergency_contact = Faker::PhoneNumber.phone_number
    myBioData.languages_spoken = Faker::Lorem.words(4)
    myBioData.complexion = Faker::Lorem.words(1)
    myBioData.height = Faker::Number.number(3)
    myBioData.marital_status = ["single", "married"].sample
    myBioData.blood_type = ["O", "A", "B-","B+"].sample
    myBioData.religion = Faker::Lorem.words(1)
    myBioData.save
  end

  # HUMAN RESOURCES
  if(randomBoolean())
    myEmployee = Employee.new( entity: myEntity )
    dayOfWeek = Faker::Time.between(7.days.ago, Time.now, :all).strftime("%A")
    myEmployee.rest_day = dayOfWeek
    myEmployee.save

    periodsOfTime = ["DAY", "WEEK", "HOUR", "MONTH"]
    periodOfTime = periodsOfTime[rand(periodsOfTime.length)]

    if( periodOfTime == "DAY" )
      amountOfMoney = randomMoney(267.32,600.05)
    elsif( periodOfTime == "WEEK" )
      amountOfMoney = randomMoney(1900.45,2900.17)
    elsif( periodOfTime == "HOUR" )
      amountOfMoney = randomMoney(60.80,82.21)
    elsif( periodOfTime == "MONTH" )
      amountOfMoney = randomMoney(15000.99,25000.05)
    end

    randomNumberOfAttendances = rand(0..30)
    randomNumberOfAttendances.times do |i|
      day = i.days.ago
      timein = Faker::Time.between(i.days.ago, Time.now, :morning).strftime("%H:%M")
      timeout = Faker::Time.between(i.days.ago, Time.now, :evening).strftime("%H:%M")

      if randomBoolean() && randomBoolean() && randomBoolean() && randomBoolean()
        # SIMULATE OVERNIGHT
        timein = Faker::Time.between(i.days.ago, Time.now, :all).strftime("%H:%M")
        timeout = Faker::Time.between(i.days.ago, Time.now, :all).strftime("%H:%M")
        myAttendance = Attendance.new( day: day, timein: timein, employee: myEmployee )
        myAttendance.save
        myAttendance = Attendance.new( day: day+1, timeout: timeout, employee: myEmployee )
        myAttendance.save
      elsif randomBoolean() && randomBoolean() && randomBoolean()
        # SIMULATE ABSENCE
        myAttendance = Attendance.new( day: day )
        myAttendance.save
      else
        # SIMULATE REGULAR ATTENDANCE
        myAttendance = Attendance.new( day: day, timein: timein, timeout: timeout, employee: myEmployee )
        myAttendance.save
      end
    end
    myBaseRate = BaseRate.new( amount: amountOfMoney, period_of_time: periodOfTime, employee: myEmployee )
    myBaseRate.save

    # For SSS Concerns
    if(randomBoolean())
      myIAS = InstitutionalAdjustmentSet.create( employee: myEmployee, institution_employee: mySSS, institutional_ID: Faker::Number.number(12) , activated: randomBoolean() )
    end

    # For Philhealth Concerns
    if(randomBoolean())
      myIAS = InstitutionalAdjustmentSet.create( employee: myEmployee, institution_employee: myPhilhealth, institutional_ID: Faker::Number.number(12) , activated: randomBoolean() )
    end

    # For Pagibig Concerns
    if(randomBoolean())
      myIAS = InstitutionalAdjustmentSet.create( employee: myEmployee, institution_employee: myPagibig, institutional_ID: Faker::Number.number(12) , activated: randomBoolean() )
    end

    # For Lump Adjustment
    if(randomBoolean() && randomBoolean() )
      LumpAdjustment.create( amount: randomMoney(100.10,1000.00), signed_type: ["ADDITION", "DEDUCTION"].sample, employee: myEmployee, description: Faker::Lorem.words(4) )
    end

    # For Rate Adjustment
    if(randomBoolean() && randomBoolean() )
      RateAdjustment.create( amount: randomMoney(100.10,1000.00), signed_type: ["ADDITION", "DEDUCTION"].sample, employee: myEmployee, description: Faker::Lorem.words(4), rate_of_time: ["DAY", "WEEK", "MONTH"].sample, activated: randomBoolean())
    end

    # For Vale
    if(randomBoolean() && randomBoolean() )
      randomDays = rand(0..30)
      timeofVale = Faker::Time.between(randomDays.days.ago, Time.now, :all)
      valeAmount = rand(2000.00..25000.00)
      valeRateOfPayment = ((valeAmount)/rand(1.00..25.00))
      valeStatus = ["APPROVED", "NOT APPROVED"].sample
      myVale = Vale.create( created_at: timeofVale, updated_at: timeofVale, employee: myEmployee, amount: valeAmount ,description: Faker::Lorem.words(4), rate_of_payment: valeRateOfPayment, rate_of_time: ["DAY", "WEEK", "MONTH"].sample, status: valeStatus )

      #Repayments
      rand(1..5).times do |i|
        maxPaymentIteration = (valeAmount / valeRateOfPayment).ceil
        totalPaid = 0
        if((valeStatus == "APPROVED") && randomBoolean() )
          rand(1..maxPaymentIteration).times do |i|

            timeofPayment = Faker::Time.between(timeofVale, Time.now, :all)
            valePayment = valeRateOfPayment*rand(0.5..2)

            if(valeAmount > totalPaid)
              currentPayment = valePayment
              RepaidVale.create( vale: myVale, amount: currentPayment, created_at: timeofPayment, updated_at: timeofPayment)
              break;
            elsif(valeAmount < totalPaid)
              currentPayment = valeAmount - totalPaid
              RepaidVale.create( vale: myVale, amount: currentPayment, created_at: timeofPayment, updated_at: timeofPayment)
            elsif(valeAmount < totalPaid)
              currentPayment = 0
              RepaidVale.create( vale: myVale, amount: currentPayment, created_at: timeofPayment, updated_at: timeofPayment)
            end

            totalPaid += currentPayment
          end
        end
      end
    end

    # For Assignments
    rand(1..5).times do |i|
      myAssignment = Assignment.new( employee: myEmployee, branch: [b1,b2,b3].sample, department: ["Human Resources","Operations","Marketing","Information Technology","Sales","Delivery"].sample, position: ["Junior","Senior"].sample, task: ["General","Idle"].sample)
      start = Faker::Time.between(30.days.ago, Time.now, :all)
      if(randomBoolean() && randomBoolean() )
        myAssignment.duration_start = start
        if(randomBoolean() && randomBoolean() )
          myAssignment.duration_finish = Faker::Time.between(start, Time.now, :all)
        end
      end
      myAssignment.save
    end

  end
end

#Constants
Constant.create( name: "hr.minimum_wage", constant: "362.50" )
Constant.create( name: "hr.default_rest_day", constant: "SUNDAY" )
