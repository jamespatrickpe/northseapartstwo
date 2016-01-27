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
myActor = Actor.create(name: 'James Patrick Pe', description: 'Administrator', logo: 'default.jpg')
myActor.save!

access = Access.new
access.actor = myActor
access.username = 'joojieman'
access.email = 'jamespatrickpe@northseaparts.com'
access.password = 'ilovetess'
access.password_confirmation = 'ilovetess'
access.hash_link = generateRandomString
access.verification = true
access.save!

permission = Permission.new
permission.access = access
permission.can = 'assess_vale'
permission.remark = Faker::Lorem.sentence
permission.save!

permission = Permission.new
permission.access = access
permission.can = 'human_resources'
permission.remark =  Faker::Lorem.sentence
permission.save!

permission = Permission.new
permission.access = access
permission.can = 'access_control'
permission.remark =  Faker::Lorem.sentence
permission.save!

#HUMAN RESOURCES

#Holiday
regularHoliday = HolidayType.create( type_name: "Regular", rate_multiplier: 2, overtime_multiplier: 2.6, rest_day_multiplier: 1.3, no_work_pay: true, overtime_rest_day_multiplier: 2.6)
specialNonWorkingHoliday = HolidayType.create( type_name: "Special Non-Working", rate_multiplier: 1.3, overtime_multiplier: 1.69, rest_day_multiplier: 1.5, no_work_pay: false, overtime_rest_day_multiplier: 1.95)
doubleHoliday = HolidayType.create( type_name: "Double Holiday", rate_multiplier: 3.0, overtime_multiplier: 1.69, rest_day_multiplier: 1.5, no_work_pay: false, overtime_rest_day_multiplier: 1.95)

Holiday.create( date_of_implementation: Date.new(2016,1,1) , name: "New Year's Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence)
Holiday.create( date_of_implementation: Date.new(2016,2,8) , name: "Chinese Lunar New Year's Day", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,3,24) , name: "Maundy Thursday", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,3,25) , name: "Good Friday", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,4,9) , name: "The Day of Valor", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,5,1) , name: "Labor Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,6,12) , name: "Ninoy Aquino Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,8,21) , name: "National Heroes Day", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,8,28) , name: "National Heroes Day holiday", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,11,1) , name: "All Saints' Day", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,12,25) , name: "Christmas Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,12,30) , name: "Rizal Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2016,12,31) , name: "New Year's Eve", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )

Holiday.create( date_of_implementation: Date.new(2015,1,1) , name: "New Year's Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence)
Holiday.create( date_of_implementation: Date.new(2015,1,2) , name: "Special non-working day after New Year", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,2,19) , name: "Chinese Lunar New Year's Day", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,4,2) , name: "Maundy Thursday", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,4,3) , name: "Good Friday", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,4,4) , name: "Holy Saturday", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,4,9) , name: "The Day of Valor", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,5,1) , name: "Labor Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,5,12) , name: "Independence Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,8,21) , name: "Ninoy Aquino Day", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,8,30) , name: "National Heroes Day", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,8,31) , name: "National Heroes Day Holiday", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,11,1) , name: "All Saints' Day", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,11,30) , name: "Bonifacio Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,12,24) , name: "Christmas Eve", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,12,25) , name: "Christmas Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,12,30) , name: "Rizal Day", holiday_type: regularHoliday, description: Faker::Lorem.sentence )
Holiday.create( date_of_implementation: Date.new(2015,12,31) , name: "New Year's Eve", holiday_type: specialNonWorkingHoliday, description: Faker::Lorem.sentence )

#Institutional Adjustment

# Employee Institutions
InstitutionalAdjustment.create( institution: "SSS", start_range: 1000, end_range: 1249.99, employer_contribution: 83.7, employee_contribution: 36.3, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 1250, end_range: 1749.99, employer_contribution: 120.5, employee_contribution: 54.5, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 1750, end_range: 2249.99, employer_contribution: 157.3, employee_contribution: 72.7, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 2250, end_range: 2749.99, employer_contribution: 194.20, employee_contribution: 90.8, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 2750, end_range: 3249.99, employer_contribution: 231.00, employee_contribution: 109.00, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 3250, end_range: 3749.99, employer_contribution: 267.80, employee_contribution: 127.20, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 3750, end_range: 4249.99, employer_contribution: 304.7, employee_contribution: 145.3, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 4250, end_range: 4749.99, employer_contribution: 341.5, employee_contribution: 163.5, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 4750, end_range: 5249.99, employer_contribution: 378.3, employee_contribution: 181.7, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 5250, end_range: 5749.99, employer_contribution: 415.20, employee_contribution: 199.8, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 5750, end_range: 6249.99, employer_contribution: 452.00, employee_contribution: 218.00, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 6250, end_range: 6749.99, employer_contribution: 488.8, employee_contribution: 236.2, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 6250, end_range: 7249.99, employer_contribution: 525.7, employee_contribution: 254.30, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 7250, end_range: 7749.99, employer_contribution: 562.5, employee_contribution: 272.5, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 7750, end_range: 8249.99, employer_contribution: 599.3, employee_contribution: 290.7, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 8250, end_range: 8749.99, employer_contribution: 636.20, employee_contribution: 308.8, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 8750, end_range: 9249.99, employer_contribution: 673.00, employee_contribution: 327.00, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 9250, end_range: 9749.99, employer_contribution: 709.80, employee_contribution: 345.20, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 9750, end_range: 10249.99, employer_contribution: 746.70, employee_contribution: 363.3, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 10250, end_range: 10749.99, employer_contribution: 783.50, employee_contribution: 381.5, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 10750, end_range: 11249.99, employer_contribution: 820.30, employee_contribution: 399.7, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 11250, end_range: 11749.99, employer_contribution: 857.20, employee_contribution: 417.8, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 11750, end_range: 12249.99, employer_contribution: 894.00, employee_contribution: 436.00, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 12250, end_range: 12749.99, employer_contribution: 930.80, employee_contribution: 454.2, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now   )
InstitutionalAdjustment.create( institution: "SSS", start_range: 12750, end_range: 13249.99, employer_contribution: 967.70, employee_contribution: 472.3 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 13250, end_range: 13749.99, employer_contribution: 1004.50, employee_contribution: 490.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 13750, end_range: 14249.99, employer_contribution: 1041.30, employee_contribution: 508.70 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 14250, end_range: 14749.99, employer_contribution: 1078.20, employee_contribution: 526.8 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "SSS", start_range: 14750, end_range: 15249.99, employer_contribution: 1135.00, employee_contribution: 545.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 15250, end_range: 15749.99, employer_contribution: 1171.80, employee_contribution: 563.20 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "SSS", start_range: 15750, end_range: 99999999999.99, employer_contribution: 1208.70, employee_contribution: 581.30 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )

InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 0.00, end_range: 8999.99, employer_contribution: 100.0, employee_contribution: 100.0 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 9000.00 , end_range: 9999.99, employer_contribution: 112.5, employee_contribution: 112.5 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now)
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 10000.00 , end_range: 10999.99, employer_contribution: 125.00, employee_contribution: 125.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 11000.00 , end_range: 11999.99, employer_contribution: 137.50, employee_contribution: 137.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 12000.00, end_range: 12999.99, employer_contribution: 150.00, employee_contribution: 150.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 13000.00, end_range: 13999.99, employer_contribution: 162.50, employee_contribution: 162.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 14000.00, end_range: 14999.99, employer_contribution: 175.00, employee_contribution: 175.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 15000.00, end_range: 15999.99, employer_contribution: 187.50, employee_contribution: 187.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 16000.00, end_range: 16999.99, employer_contribution: 200.00, employee_contribution: 200.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 17000.00, end_range: 17999.99, employer_contribution: 212.50, employee_contribution: 212.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 18000.00, end_range: 18999.99, employer_contribution: 225.00, employee_contribution: 225.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 19000.00, end_range: 19999.99, employer_contribution: 237.50, employee_contribution: 237.50, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 20000.00, end_range: 20999.99, employer_contribution: 250.00, employee_contribution: 250.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 21000.00, end_range: 21999.99, employer_contribution: 262.50, employee_contribution: 262.50  , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now)
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 22000.00, end_range: 22999.99, employer_contribution: 275.00, employee_contribution: 275.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 23000.00, end_range: 23999.99, employer_contribution: 287.50, employee_contribution: 287.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 24000.00, end_range: 24999.99, employer_contribution: 300.00, employee_contribution: 300.00, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 25000.00, end_range: 25999.99, employer_contribution: 312.50, employee_contribution: 312.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 26000.00, end_range: 26999.99, employer_contribution: 325.00, employee_contribution: 325.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 27000.00, end_range: 27999.99, employer_contribution: 337.50, employee_contribution: 337.50, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 28000.00, end_range: 28999.99, employer_contribution: 350.00, employee_contribution: 350.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 29000.00, end_range: 29999.99, employer_contribution: 362.50, employee_contribution: 362.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 30000.00, end_range: 30999.99, employer_contribution: 375.00, employee_contribution: 375.00, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 31000.00, end_range: 31999.99, employer_contribution: 387.50, employee_contribution: 387.50, period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now  )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 32000.00, end_range: 32999.99, employer_contribution: 400.00, employee_contribution: 400.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 33000.00, end_range: 33999.99, employer_contribution: 412.50, employee_contribution: 412.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 34000.00, end_range: 34999.99, employer_contribution: 425.00, employee_contribution: 425.00 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now )
InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 35000.00, end_range: 99999999999.99, employer_contribution: 437.50, employee_contribution:  437.50 , period_of_time: "MONTH", contribution_type: "LUMP", date_of_effectivity: Time.now)

InstitutionalAdjustment.create( institution: "PAGIBIG", start_range: 0.00, end_range: 1500.00, employer_contribution: 0.01, employee_contribution:  0.02 , period_of_time: "MONTH", contribution_type: "PERCENTAGE", date_of_effectivity: Time.now)
InstitutionalAdjustment.create( institution: "PAGIBIG", start_range: 1500.00, end_range: 99999999999.99, employer_contribution: 0.02, employee_contribution:  0.02 , period_of_time: "MONTH", contribution_type: "PERCENTAGE", date_of_effectivity: Time.now)

# Branches
north_sea = Branch.create(name: 'North Sea Cainta')
greco = Branch.create(name: 'GRECO Warehouse')
biofin = Branch.create(name: 'BIOFIN')
green_terrain = Branch.create(name: 'GREEN TERRAIN')
ampid = Branch.create(name: 'Ampid Diesel Trading')
generic = Branch.create(name: 'Generic')

# Telephone for Branches
Telephone.create( description: "Main Number 1", digits: "6451514", rel_model_id: north_sea.id, rel_model_type: 'Branch')
Telephone.create( description: "Main Number 2", digits: "6452237", rel_model_id: north_sea.id, rel_model_type: 'Branch')
Telephone.create( description: "Fax", digits: "6452246", rel_model_id: north_sea.id, rel_model_type: 'Branch')
Telephone.create( description: "Cellphone", digits: "09237354641", rel_model_id: north_sea.id, rel_model_type: 'Branch')
Telephone.create( description: "Main Number", digits: "9427048", rel_model_id: greco.id, rel_model_type: 'Branch')
Telephone.create( description: "Main Number", digits: "6478092", rel_model_id: biofin.id, rel_model_type: 'Branch')

# Addresses for Branches
Address.create( description: "North Sea Parts, Marcos Highway, Cainta, Rizal", longitude: 14.622056, latitude: 121.106819, rel_model_id: north_sea.id, rel_model_type: 'Branch')
Address.create( description: "Greco Warehouse, Sumulong Highway, Antipolo, Rizal", longitude: 14.616369, latitude: 121.138520, rel_model_id: greco.id, rel_model_type: 'Branch')
Address.create( description: "Biofin Petshop, Sumulong Highway, Antipolo, Rizal", longitude: 14.617416, latitude: 121.134781, rel_model_id: biofin.id, rel_model_type: 'Branch')

# Digitals for Branches
Digital.new( description: "email", url: "northseaparts@yahoo.com", rel_model_id: north_sea.id, rel_model_type: 'Branch')
Digital.new( description: "email", url: "northseaparts@gmail.com", rel_model_id: north_sea.id, rel_model_type: 'Branch')
Digital.new( description: "email", url: "biofinbreeding@yahoo.com.ph", rel_model_id: biofin.id, rel_model_type: 'Branch')

#Constants
Constant.create( constant_type: 'human_resources.minimum_wage', value: '362.50', name: 'Minimum Wage', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.preferred_rest_day', value: 'SUNDAY', name: 'Preferred Rest Day', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.contract_days', value: '366', name: 'Default Duration of Contract (Days)', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.time_start', value: '08:00', name: 'Usual time Start for Employee', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.time_end', value: '17:00', name: 'Usual time End for Employee', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.night_shift_differential_start', value: '22:00', name: 'Start of Night Shift Differential', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.night_shift_differential_end', value: '05:00', name: 'End of Night Shift Differential', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.night_shift_differential_multiplier', value: '0.1', name: 'Multiplier for NSD', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.start_lunch_break', value: '2000-01-01 12:00:00 +0800', name: 'Default Duration of Contract (Days)', remark: nil, date_of_effectivity: Time.now )
Constant.create( constant_type: 'human_resources.end_lunch_break', value: '2000-01-01 13:00:00 +0800', name: 'Default Duration of Contract (Days)', remark: nil, date_of_effectivity: Time.now )

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
  current_logo = ['default_1.jpg','default_2.jpg','default_3.jpg','default_4.jpg','default_5.jpg','default_6.jpg','default_7.jpg','default_8.jpg','default_9.jpg','default_10.jpg','default.jpg'].sample
  myActor = Actor.new(name: Faker::Name.name , description: Faker::Lorem.sentence(3, true))
  myActor[:logo] = current_logo
  myActor.save!

  # ACCESS
  if ( 8.in(10) )
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
    myAccess.hash_link = generateRandomString
    myAccess.verification = randomBoolean
    myAccess.last_login = Time.now - rand(0..72000).hours
    myAccess.save!

    #Permission
    rand(0..2).times do |i|
      if randomBoolean
        permission = Permission.new
        permission.access = access
        permission.can = ['access_control','assess_vale','human_resources'].sample
        permission.remark =  Faker::Lorem.sentence
        permission.save!
      end
    end
  end

  #Related File Sets
  rand(0..10).times do |i|
    if randomBoolean
      myFileSet = FileSet.new
      myFileSet[:file] = ['export_table_1.csv','export_table_2.csv','export_table_3.csv','export_table_4.csv','export_table_5.csv'].sample
      myFileSet.label = Faker::Lorem.sentence
      myFileSet.rel_file_set_id = myActor.id
      myFileSet.rel_file_set_type = 'Actor'
      myFileSet.save!
    end
  end

  #Related Image Sets
  rand(0..10).times do |i|
    if randomBoolean
      myImageSet = ImageSet.new
      myImageSet[:picture] = ['file_01.jpg','file_02.png','file_03.gif','file_04.jpg','file_05.jpg'].sample
      myImageSet.description = Faker::Lorem.sentence
      myImageSet.rel_image_set_id = myActor.id
      myImageSet.rel_image_set_type = 'Actor'
      myImageSet.save!
    end
  end

  #Digital
  rand(0..5).times do |i|
    myDigital = Digital.new( description: Faker::Lorem.sentence, url: Faker::Internet.url)
    myDigital.rel_model_id = myActor.id
    myDigital.rel_model_type = 'Actor'
    myDigital.save!
  end

  #Telephony
  rand(0..5).times do |i|
    myTelephony = Telephone.new( description: Faker::Lorem.sentence, digits: Faker::PhoneNumber.phone_number)
    myTelephony.rel_model_id = myActor.id
    myTelephony.rel_model_type = 'Actor'
    myTelephony.save!
  end

  #Addresses
  rand(0..5).times do |i|
    completeAddress = Faker::Address.building_number + ' '+ Faker::Address.street_name + ' ' + Faker::Address.street_address + ' ' + Faker::Address.city + ' ' + Faker::Address.country
    myAddress = Address.new( description: completeAddress, longitude: Faker::Address.longitude, latitude: Faker::Address.latitude)
    myAddress.rel_model_id = myActor.id
    myAddress.rel_model_type = 'Actor'
    myAddress.save!
  end

  # BIODATA
  if(randomBoolean())
    myBioData = Biodatum.new()
    myBioData.actor = myActor
    myBioData.education = Faker::Company.name
    myBioData.career_experience = Faker::Lorem.sentence(3, false, 4)
    myBioData.notable_accomplishments = Faker::Lorem.sentence(3, false, 4)
    myBioData.date_of_birth = Faker::Date.between(600.months.ago, 216.months.ago)
    myBioData.family_members = Faker::Lorem.sentence(3, false, 4)
    myBioData.citizenship = Faker::Address.country
    myBioData.gender = ["male", "female"].sample
    myBioData.place_of_birth = Faker::Address.city
    myBioData.emergency_contact = Faker::PhoneNumber.phone_number
    myBioData.languages_spoken = Faker::Lorem.sentence(3, false, 4)
    myBioData.complexion = Faker::Lorem.sentence(3, false, 4)
    myBioData.height_cm = Faker::Number.number(3)
    myBioData.marital_status = ["single", "married", "married with 2 wives"].sample
    myBioData.blood_type = ["O", "A", "B-","B+"].sample
    myBioData.religion = Faker::Lorem.sentence(3, false, 4)
    myBioData.save
  end

  # HUMAN RESOURCES
  if 80.in(100)
    # ids = Branch.pluck(:id).shuffle
    # myBranch = Branch.where(id: ids)
    myEmployee = Employee.new( actor: myActor, branch: Branch.all.shuffle.first )

    #Attendances
    rand(360..720).times do |i|
      myDate = DateTime.now - i.days
      dateOfAttendance = Date.new(myDate.year , myDate.month, myDate.day)
      # timein = Time.new( myDate.year , myDate.month, myDate.day, (0..12), rand(0..59), rand(0..59) )
      # timeout = Time.new( myDate.year , myDate.month, myDate.day, rand(12..23), rand(0..59), rand(0..59) )
      time_in = rand(0..12).to_s+':'+rand(0..59).to_s+':'+rand(0..59).to_s
      time_out = rand(12..23).to_s+':'+rand(0..59).to_s+':'+rand(0..59).to_s
      remark = Faker::Lorem.word
      if 10.in(100)
        myAttendance = Attendance.new(date_of_attendance: dateOfAttendance, timein: time_in, employee: myEmployee, remark: remark )
        myAttendance.save
        time_out = rand(0..12).to_s+':'+rand(0..59).to_s+':'+rand(0..59).to_s
        myAttendance = Attendance.new(date_of_attendance: dateOfAttendance + 1.day, timeout: time_out, employee: myEmployee, remark: remark )
        myAttendance.save
        myDate = myDate + 1.days
      elsif 10.in(100)
        myDate = myDate - rand(1..10).days
      elsif 70.in(100)
        myAttendance = Attendance.new(date_of_attendance: dateOfAttendance, timein: "08:00:00", timeout: "17:00:00", employee: myEmployee, remark: remark )
        myAttendance.save
      else
        myAttendance = Attendance.new(date_of_attendance: dateOfAttendance, timein: time_in, timeout: time_out, employee: myEmployee, remark: remark )
        myAttendance.save
      end
    end

    #Leaves
    if 80.in(100)
      my_leave = Leave.new()
      my_leave.remark = Faker::Lorem.sentence
      my_leave.type_of_leave = ["MATERNITY","PATERNITY","SICK"].sample()
      my_leave.employee = myEmployee
      my_leave.start_of_effectivity = rand(500..1000).hours.ago
      my_leave.end_of_effectivity = rand(300..501).hours.ago
      my_leave.save!
    end

    # Rest Days
    rand(1..3).times do |i|
    dayOfWeek = Faker::Time.between(7.days.ago, Time.now, :all).strftime("%A")
    restday = RestDay.new(day: dayOfWeek, employee: myEmployee)
    restday.date_of_effectivity = rand(720..72000).hours.ago
    restday.save!
    end

    numberOfWorkPeriods = rand(1..4)
    numberOfWorkPeriods.times do
      if 7.in(10)
        start_time = '08:00:00'
        end_time = '17:00:00'
      elsif 3.in(10)
        start_time = '09:00:00'
        end_time = '18:00:00'
      elsif 2.in(10)
        start_time = '17:00:00'
        end_time = '05:00:00'
      else
        start_time = '01:00:00'
        end_time = '06:00:00'
      end
      workperiod = RegularWorkPeriod.new(remark: Faker::Lorem.word, employee: myEmployee, start_time: start_time, end_time: end_time )
      workperiod.date_of_effectivity = rand(720..72000).hours.ago
      workperiod.save!
    end

    rand(0..5).times do
      dutyStatus = DutyStatus.new(remark: Faker::Lorem.sentence, employee: myEmployee)
      if 5.in(10)
        active = -> { true }
      else
        active = -> { false }
      end
      dutyStatus.active = active.call
      dutyStatus.date_of_effectivity = rand(720..72000).hours.ago
      dutyStatus.save!
    end

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

    # Base Rate
    rand(1..5).times do |i|
      periodOfTime = ["DAY", "WEEK", "HOUR", "MONTH"].sample
      if( periodOfTime == "DAY" )
        amountOfMoney = randomMoney(267.32,600.05)
      elsif( periodOfTime == "WEEK" )
        amountOfMoney = randomMoney(1900.45,2900.17)
      elsif( periodOfTime == "HOUR" )
        amountOfMoney = randomMoney(60.80,82.21)
      elsif( periodOfTime == "MONTH" )
        amountOfMoney = randomMoney(15000.99,25000.05)
      end
      signed_type = -> { [false,true].sample }
      myBaseRate = BaseRate.new(remark: Faker::Lorem.sentence(4),
                                amount: amountOfMoney,
                                period_of_time: periodOfTime,
                                employee: myEmployee,
                                start_of_effectivity: Faker::Time.between(Time.now, Time.now - 300.days, :all),
                                end_of_effectivity: Faker::Time.between(Time.now + 300.days, Time.now, :all),
                                signed_type: signed_type.call,
                                rate_type: ['base', 'allowance', 'other'].sample
      )
      myBaseRate.save
    end

    # For Lump Adjustment
    numberOfDuties = rand(1..5)
    numberOfDuties.times do
      dutyStatus = DutyStatus.new(remark: Faker::Lorem.sentence, employee: myEmployee)
      active = -> { [false,true].sample }
      dutyStatus.active = active.call
      dutyStatus.created_at = rand(720..72000).hours.ago
      dutyStatus.save!
    end

    randomNumberOfLumpAdjustment = rand(0..30)
    randomNumberOfLumpAdjustment.times do |i|
      lumpAdjustment = LumpAdjustment.new()
      signed_type = -> { [false,true].sample }
      lumpAdjustment.amount = randomMoney(100.10,1000.00)
      lumpAdjustment.signed_type = signed_type.call
      lumpAdjustment.employee = myEmployee
      lumpAdjustment.remark = Faker::Lorem.word
      lumpAdjustment.date_of_effectivity = rand(720..72000).hours.ago
      lumpAdjustment.save!
    end

    # For Rate Adjustment
    if(randomBoolean() && randomBoolean() )
      RateAdjustment.create( amount: randomMoney(100.10,1000.00), signed_type: ["ADDITION", "DEDUCTION"].sample, employee: myEmployee, description: Faker::Lorem.sentence, rate_of_time: ["DAY", "WEEK", "MONTH"].sample, activated: randomBoolean())
    end

    # For Payroll
    rand(0..2).times do |i|

      if 9.in(10)
        my_payroll = Payroll.new
        my_payroll.article = "SSS"
        boolean_of_applicability = -> { [false,true].sample }
        my_payroll.applicability = boolean_of_applicability.call
        my_payroll.date_of_effectivity = rand(720..72000).hours.ago
        my_payroll.remark = Faker::Lorem.word
        my_payroll.employee = myEmployee
        my_payroll.save!
      end

      if 9.in(10)
        my_payroll = Payroll.new
        my_payroll.article = "PHILHEALTH"
        boolean_of_applicability = -> { [false,true].sample }
        my_payroll.applicability = boolean_of_applicability.call
        my_payroll.date_of_effectivity = rand(720..72000).hours.ago
        my_payroll.remark = Faker::Lorem.word
        my_payroll.employee = myEmployee
        my_payroll.save!
      end

      if 9.in(10)
        my_payroll = Payroll.new
        my_payroll.article = "PAGIBIG"
        boolean_of_applicability = -> { [false,true].sample }
        my_payroll.applicability = boolean_of_applicability.call
        my_payroll.date_of_effectivity = rand(720..72000).hours.ago
        my_payroll.remark = Faker::Lorem.word
        my_payroll.employee = myEmployee
        my_payroll.save!
      end

    end

    # For Vales
    rand(0..2).times do |i|
      if 8.in(10)
        my_vale = Vale.new
        approval_status = -> { [false,true].sample }
        my_vale.approval_status = approval_status.call
        my_vale.employee = myEmployee
        my_vale.amount = randomMoney(900.10,5000.00)
        my_vale.amount_of_deduction = randomMoney(10.00,900.00)
        my_vale.period_of_deduction = ['MONTH','DAY','WEEK','YEAR'].sample
        my_vale.remark = Faker::Lorem.word
        my_vale.date_of_effectivity = rand(720..72000).hours.ago
        my_vale.save!
        if 5.in(10)
          rand(1..3).times do |i|
          my_vale_adjustment = ValeAdjustment.new
          my_vale_adjustment.vale = my_vale
          my_vale_adjustment.amount = randomMoney(10.10,250.00)
          vale_signed_type = -> { [false,true].sample }
          my_vale_adjustment.signed_type = vale_signed_type.call
          my_vale_adjustment.remark = Faker::Lorem.word
          my_vale_adjustment.date_of_effectivity = rand(720..72000).hours.ago
          my_vale_adjustment.save!
          end
        end
      end
    end

  end
end