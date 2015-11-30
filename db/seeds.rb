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
myActor = Actor.create(name: 'James Patrick Pe', description: 'Administrator')
myActor.save

access = Access.new
access.actor = myActor
access.username = 'joojieman'
access.email = 'jamespatrickpe@northseaparts.com'
access.password = 'ilovetess'
access.password_confirmation = 'ilovetess'
access.hashlink = generateRandomString
access.verification = true
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
sss = Actor.create(name: "SSS" , description: "SSS", logo: 'sample.jpg')
philhealth = Actor.create(name: "Philhealth" , description: "Philhealth", logo: 'sample.jpg')
pagibig = Actor.create(name: "Pagibig" , description: "Pagibig", logo: 'sample.jpg')

mySSS = InstitutionEmployee.create( actor: sss, compensation_type: "LUMP")
myPhilhealth = InstitutionEmployee.create( actor: philhealth, compensation_type: "LUMP")
myPagibig = InstitutionEmployee.create( actor: pagibig, compensation_type: "PERCENTAGE")

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
northseaone = Actor.create(name: "North Sea Parts One" , description: "Original North Sea Parts Base", logo: 'sample.jpg')
amppidiesel = Actor.create(name: "Ampid Diesel Trading" , description: "Ampid Diesel Trading", logo: 'sample.jpg')
stockhouse = Actor.create(name: "North Sea Stock House" , description: "Stockhouse", logo: 'sample.jpg')

cd_northseaone = ContactDetail.create( actor: northseaone)
  Address.create( description: "North Sea Parts, Marcos Highway, Cainta, Rizal", longitude: "14.6058853", latitude: "121.1292978", contact_detail: cd_northseaone  )
  Telephone.create( description: "Telephone Number 1", digits: "6451514", contact_detail: cd_northseaone  )
  Telephone.create( description: "Telephone Number 2", digits: "6452237", contact_detail: cd_northseaone  )
  Digital.create( description: "Email 1", url: "northseaparts@yahoo.com", contact_detail: cd_northseaone )
  Digital.create( description: "Email 2", url: "northseaparts@gmail.com", contact_detail: cd_northseaone )

cd_ampidiesel = ContactDetail.create( actor: amppidiesel)
  Address.create( description: "Ampid Diesel Trading, General Luna Avenue, San Mateo, Rizal", longitude: "14.698516", latitude: "121.121944", contact_detail: cd_ampidiesel  )
  Telephone.create( description: "Telephone Number 1", digits: "9489991", contact_detail: cd_ampidiesel  )

cd_stockhouse = ContactDetail.create( actor: stockhouse)
  Address.create( description: "North Sea Stockhouse, Sumulong Highway, Antipolo, Rizal", longitude: "14.6171302", latitude: "121.1340643", contact_detail: cd_stockhouse  )

b1 = Branch.create( actor: northseaone )
b2 = Branch.create( actor: amppidiesel )
b3 = Branch.create( actor: stockhouse )

#Constants
Constant.create( name: "human_resources.minimum_wage", constant: "362.50", description: "Minimum Wage")
Constant.create( name: "human_resources.preferred_rest_day", constant: "SUNDAY", description: "Preferred Rest Day" )
Constant.create( name: "human_resources.default_duration_of_contract_days", constant: "366", description: "Default Duration of Contract (Days)" )

#Departments
hr = Department.new(label: "Human Resources", description: "no description")
hr.save
sales = Department.new(label: "Sales", description: "no description")
sales.save
ops = Department.new(label: "Operations", description: "no description")
ops.save
marketing = Department.new(label: "Marketing", description: "no description")
marketing.save
accfin = Department.new(label: "Accounting and Finance", description: "no description")
accfin.save
admin = Department.new(label: "Administration", description: "no description")
admin.save

#  ----------------------------------------------------------------------------------- RANDOM SEED DATA ------------------------------------------------------------------------

def randomBoolean()
  return [true, false].sample
end

def randomMoney( lower, upper)
  return rand(lower..upper)
end

#POSITIONS
numberOfPositions = 50
numberOfPositions.times do |i|
  departments = [hr, sales, ops, marketing, accfin, admin]
  department = departments[rand(departments.length)]
  myPosition = Position.new(description: Faker::Lorem.words(32), label: Faker::Lorem.words(3) , department: department )
  myPosition.save
end

#ENTITIES
numberOfActors = 50
numberOfActors.times do |i|
  #Actor
  myActor = Actor.new(name: Faker::Name.name , description: Faker::Lorem.sentence(3, true), logo: 'barack_obama.jpg')
  myActor.save

  # ACCESS
  if (randomBoolean())
    #Access
    randomPassword = Faker::Internet.password(10, 20)
    randomEmail = Faker::Internet.email

    randomUserName = Faker::Internet.user_name
    if(randomUserName.length < 3)
      randomUserName << Faker::Internet.user_name
    end

    if(Access.find_by_username(randomUserName))
      randomUserName = Faker::Internet.user_name
    end

    myAccess = Access.new
    myAccess.actor = myActor
    myAccess.username = randomUserName
    myAccess.email = randomEmail
    myAccess.password = randomPassword
    myAccess.password_confirmation = randomPassword
    myAccess.hashlink = generateRandomString
    myAccess.verification = randomBoolean
    myAccess.save

    #ContactDetail
    myContactDetail = ContactDetail.create( actor: myActor)
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
    myBioData.actor = myActor
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
    myEmployee = Employee.new( actor: myActor )

    if(randomBoolean())
      myStatus = "ACTIVE"
    else
      myStatus = "INACTIVE"
    end

    dayOfWeek = Faker::Time.between(7.days.ago, Time.now, :all).strftime("%A")
    restday = Restday.new(day: dayOfWeek, employee: myEmployee); restday.save
    dutyStatus = DutyStatus.new(description: Faker::Lorem.words(16), label: myStatus, employee: myEmployee);
    dutyStatus.save
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
      timein = Faker::Time.between(day, Time.now, :morning)
      timeout = Faker::Time.between(day, Time.now, :evening)

      if randomBoolean() && randomBoolean() && randomBoolean() && randomBoolean()
        # SIMULATE OVERNIGHT
        currentDay = i.days.ago
        timein = Faker::Time.between(currentDay, Time.now, :all)
        timeout = Faker::Time.between(currentDay+1.day, Time.now, :all)
        myAttendance = Attendance.new(timein: timein, employee: myEmployee )
        myAttendance.save
        myAttendance = Attendance.new( timeout: timeout, employee: myEmployee )
        myAttendance.save
      else
        # SIMULATE REGULAR ATTENDANCE
        myAttendance = Attendance.new( timein: timein, timeout: timeout, employee: myEmployee )
        myAttendance.save
      end
    end

    randomNumberofBaseRates = rand(10..30)
    randomNumberofBaseRates.times do |i|

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

      myBaseRate = BaseRate.new(description: Faker::Lorem.words(4) ,amount: amountOfMoney, period_of_time: periodOfTime, employee: myEmployee, start_of_effectivity: Faker::Time.between(Time.now, Time.now - 300.days, :all), end_of_effectivity: Faker::Time.between(Time.now + 300.days, Time.now, :all), signed_type: ["ADDITION", "DEDUCTION"].sample )
      myBaseRate.save
    end


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
    randomNumberOfLumpAdjustment = rand(0..30)
    randomNumberOfLumpAdjustment.times do |i|
      LumpAdjustment.create( amount: randomMoney(100.10,1000.00), signed_type: ["ADDITION", "DEDUCTION"].sample, employee: myEmployee, description: Faker::Lorem.words(4), date_of_effectivity:Faker::Time.between(Time.now, Time.now - 300.days, :all))
    end

    # For Rate Adjustment
    if(randomBoolean() && randomBoolean() )
      RateAdjustment.create( amount: randomMoney(100.10,1000.00), signed_type: ["ADDITION", "DEDUCTION"].sample, employee: myEmployee, description: Faker::Lorem.words(4), rate_of_time: ["DAY", "WEEK", "MONTH"].sample, activated: randomBoolean())
    end

    # For AdvancedPaymentsToEmployee
    if(randomBoolean() && randomBoolean() )
      randomDays = rand(0..30)
      timeOfAdvancedPaymentsToEmployee = Faker::Time.between(randomDays.days.ago, Time.now, :all)
      advancedPaymentsToEmployeeAmount = rand(2000.00..25000.00)
      advancedPaymentsToEmployeeRateOfPayment = ((advancedPaymentsToEmployeeAmount)/rand(1.00..25.00))
      advancedPaymentsToEmployeeStatus = ["APPROVED", "NOT APPROVED"].sample
      myAdvancedPaymentsToEmployee = AdvancedPaymentsToEmployee.create( created_at: timeOfAdvancedPaymentsToEmployee, updated_at: timeOfAdvancedPaymentsToEmployee, employee: myEmployee, amount: advancedPaymentsToEmployeeAmount ,description: Faker::Lorem.words(4), rate_of_payment: advancedPaymentsToEmployeeRateOfPayment, rate_of_time: ["DAY", "WEEK", "MONTH"].sample, status: advancedPaymentsToEmployeeStatus )
      myAdvancedPaymentsToEmployee.save

      #Repayments
      rand(1..5).times do |i|
        maxPaymentIteration = (advancedPaymentsToEmployeeAmount / advancedPaymentsToEmployeeRateOfPayment).ceil
        totalPaid = 0
        if((advancedPaymentsToEmployeeStatus == "APPROVED") && randomBoolean() )
          rand(1..maxPaymentIteration).times do |i|

            timeofPayment = Faker::Time.between(timeOfAdvancedPaymentsToEmployee, Time.now, :all)
            advancedPaymentsToEmployeePayment = advancedPaymentsToEmployeeRateOfPayment*rand(0.5..2)
            myRepaidPaymentsFromEmployee = RepaidPaymentsFromEmployee.new

            myRepaidPaymentsFromEmployee.advanced_payments_to_employee = myAdvancedPaymentsToEmployee
            myRepaidPaymentsFromEmployee.created_at = timeofPayment
            myRepaidPaymentsFromEmployee.updated_at = timeofPayment
            currentPayment = 0
            if(advancedPaymentsToEmployeeAmount > totalPaid)
              currentPayment = advancedPaymentsToEmployeePayment
            elsif(advancedPaymentsToEmployeeAmount < totalPaid)
              currentPayment = advancedPaymentsToEmployeeAmount - totalPaid
            elsif(advancedPaymentsToEmployeeAmount < totalPaid)
              currentPayment = 0
            end
            myRepaidPaymentsFromEmployee.amount = currentPayment
            myRepaidPaymentsFromEmployee.save
            totalPaid += currentPayment
          end
        end
      end


    end
  end
end