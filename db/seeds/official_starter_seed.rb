include ApplicationHelper

module OfficialStarterSeed

  puts " == Loading Official Seed Starter Package 06/10/16 =="

  #Administrator
  mySystemAccount = SystemAccount.new
  mySystemAccount.name = 'James Patrick Pe'
  mySystemAccount.remark = 'Administrator'
  mySystemAccount.logo = 'default.jpg'
  mySystemAccount.save!

  #Administrator's Access
  access = Access.new
  access.system_account_id = mySystemAccount.id
  access.email = 'jamespatrickpe@gmail.com'
  access.password = 'ilovetess'
  access.password_confirmation = 'ilovetess'
  access.confirmed_at = Time.now - rand(0..400).hours
  access.save!

  utilities = ExpenseCategory.new
  utilities.name = 'Utilities'
  utilities.remark = 'Operational Overhead'
  utilities.save!

  telephone = ExpenseCategory.new
  telephone.parent_expense_id = utilities.id
  telephone.name = 'Telephone'
  telephone.save!

  mobile = ExpenseCategory.new
  mobile.parent_expense_id = telephone.id
  mobile.name = 'Mobile'
  mobile.save!

  landline = ExpenseCategory.new
  landline.parent_expense_id = telephone.id
  landline.name = 'Landline'
  landline.save!

  fuel = ExpenseCategory.new
  fuel.parent_expense_id = utilities.id
  fuel.name = 'Fuel'
  fuel.save!

  water = ExpenseCategory.new
  water.parent_expense_id = utilities.id
  water.name = 'Water'
  water.save!

  electricity = ExpenseCategory.new
  electricity.parent_expense_id = utilities.id
  electricity.name = 'Electricity'
  electricity.save!

  internet = ExpenseCategory.new
  internet.parent_expense_id = utilities.id
  internet.name = 'Internet'
  internet.save!

  insurance = ExpenseCategory.new
  insurance.name = 'Insurance'
  insurance.remark = 'Operational Contingencies'
  insurance.save!


  # Default Permissions
  # Canceled for Devise Integration
  # permission = Permission.new
  # permission.access = access
  # permission.can = 'assess_vale'
  # permission.remark = Faker::Lorem.sentence
  # permission.save!
  #
  # permission = Permission.new
  # permission.access = access
  # permission.can = 'human_resources'
  # permission.remark =  Faker::Lorem.sentence
  # permission.save!
  #
  # permission = Permission.new
  # permission.access = access
  # permission.can = 'access_control'
  # permission.remark =  Faker::Lorem.sentence
  # permission.save!

  #Institutional Adjustment
  InstitutionalAdjustment.create( institution: "SSS", start_range: 1000, end_range: 1249.99, employer_contribution: 83.7, employee_contribution: 36.3, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 1250, end_range: 1749.99, employer_contribution: 120.5, employee_contribution: 54.5, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 1750, end_range: 2249.99, employer_contribution: 157.3, employee_contribution: 72.7, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 2250, end_range: 2749.99, employer_contribution: 194.20, employee_contribution: 90.8, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 2750, end_range: 3249.99, employer_contribution: 231.00, employee_contribution: 109.00, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 3250, end_range: 3749.99, employer_contribution: 267.80, employee_contribution: 127.20, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 3750, end_range: 4249.99, employer_contribution: 304.7, employee_contribution: 145.3, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 4250, end_range: 4749.99, employer_contribution: 341.5, employee_contribution: 163.5, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 4750, end_range: 5249.99, employer_contribution: 378.3, employee_contribution: 181.7, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 5250, end_range: 5749.99, employer_contribution: 415.20, employee_contribution: 199.8, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 5750, end_range: 6249.99, employer_contribution: 452.00, employee_contribution: 218.00, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 6250, end_range: 6749.99, employer_contribution: 488.8, employee_contribution: 236.2, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 6250, end_range: 7249.99, employer_contribution: 525.7, employee_contribution: 254.30, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 7250, end_range: 7749.99, employer_contribution: 562.5, employee_contribution: 272.5, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 7750, end_range: 8249.99, employer_contribution: 599.3, employee_contribution: 290.7, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 8250, end_range: 8749.99, employer_contribution: 636.20, employee_contribution: 308.8, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 8750, end_range: 9249.99, employer_contribution: 673.00, employee_contribution: 327.00, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 9250, end_range: 9749.99, employer_contribution: 709.80, employee_contribution: 345.20, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 9750, end_range: 10249.99, employer_contribution: 746.70, employee_contribution: 363.3, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 10250, end_range: 10749.99, employer_contribution: 783.50, employee_contribution: 381.5, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 10750, end_range: 11249.99, employer_contribution: 820.30, employee_contribution: 399.7, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 11250, end_range: 11749.99, employer_contribution: 857.20, employee_contribution: 417.8, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 11750, end_range: 12249.99, employer_contribution: 894.00, employee_contribution: 436.00, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 12250, end_range: 12749.99, employer_contribution: 930.80, employee_contribution: 454.2, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now   )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 12750, end_range: 13249.99, employer_contribution: 967.70, employee_contribution: 472.3 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 13250, end_range: 13749.99, employer_contribution: 1004.50, employee_contribution: 490.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 13750, end_range: 14249.99, employer_contribution: 1041.30, employee_contribution: 508.70 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 14250, end_range: 14749.99, employer_contribution: 1078.20, employee_contribution: 526.8 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 14750, end_range: 15249.99, employer_contribution: 1135.00, employee_contribution: 545.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 15250, end_range: 15749.99, employer_contribution: 1171.80, employee_contribution: 563.20 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "SSS", start_range: 15750, end_range: 99999999999.99, employer_contribution: 1208.70, employee_contribution: 581.30 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )

  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 0.00, end_range: 8999.99, employer_contribution: 100.0, employee_contribution: 100.0 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 9000.00 , end_range: 9999.99, employer_contribution: 112.5, employee_contribution: 112.5 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now)
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 10000.00 , end_range: 10999.99, employer_contribution: 125.00, employee_contribution: 125.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 11000.00 , end_range: 11999.99, employer_contribution: 137.50, employee_contribution: 137.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 12000.00, end_range: 12999.99, employer_contribution: 150.00, employee_contribution: 150.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 13000.00, end_range: 13999.99, employer_contribution: 162.50, employee_contribution: 162.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 14000.00, end_range: 14999.99, employer_contribution: 175.00, employee_contribution: 175.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 15000.00, end_range: 15999.99, employer_contribution: 187.50, employee_contribution: 187.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 16000.00, end_range: 16999.99, employer_contribution: 200.00, employee_contribution: 200.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 17000.00, end_range: 17999.99, employer_contribution: 212.50, employee_contribution: 212.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 18000.00, end_range: 18999.99, employer_contribution: 225.00, employee_contribution: 225.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 19000.00, end_range: 19999.99, employer_contribution: 237.50, employee_contribution: 237.50, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 20000.00, end_range: 20999.99, employer_contribution: 250.00, employee_contribution: 250.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 21000.00, end_range: 21999.99, employer_contribution: 262.50, employee_contribution: 262.50  , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now)
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 22000.00, end_range: 22999.99, employer_contribution: 275.00, employee_contribution: 275.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 23000.00, end_range: 23999.99, employer_contribution: 287.50, employee_contribution: 287.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 24000.00, end_range: 24999.99, employer_contribution: 300.00, employee_contribution: 300.00, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 25000.00, end_range: 25999.99, employer_contribution: 312.50, employee_contribution: 312.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 26000.00, end_range: 26999.99, employer_contribution: 325.00, employee_contribution: 325.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 27000.00, end_range: 27999.99, employer_contribution: 337.50, employee_contribution: 337.50, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 28000.00, end_range: 28999.99, employer_contribution: 350.00, employee_contribution: 350.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 29000.00, end_range: 29999.99, employer_contribution: 362.50, employee_contribution: 362.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 30000.00, end_range: 30999.99, employer_contribution: 375.00, employee_contribution: 375.00, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 31000.00, end_range: 31999.99, employer_contribution: 387.50, employee_contribution: 387.50, period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now  )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 32000.00, end_range: 32999.99, employer_contribution: 400.00, employee_contribution: 400.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 33000.00, end_range: 33999.99, employer_contribution: 412.50, employee_contribution: 412.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 34000.00, end_range: 34999.99, employer_contribution: 425.00, employee_contribution: 425.00 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now )
  InstitutionalAdjustment.create( institution: "PHILHEALTH", start_range: 35000.00, end_range: 99999999999.99, employer_contribution: 437.50, employee_contribution:  437.50 , period_of_time: "MONTH", contribution_type: "LUMP", datetime_of_implementation: Time.now)

  InstitutionalAdjustment.create( institution: "PAGIBIG", start_range: 0.00, end_range: 1500.00, employer_contribution: 0.01, employee_contribution:  0.02 , period_of_time: "MONTH", contribution_type: "PERCENTAGE", datetime_of_implementation: Time.now)
  InstitutionalAdjustment.create( institution: "PAGIBIG", start_range: 1500.00, end_range: 99999999999.99, employer_contribution: 0.02, employee_contribution:  0.02 , period_of_time: "MONTH", contribution_type: "PERCENTAGE", datetime_of_implementation: Time.now)

  #Holiday
  regularHoliday = HolidayType.create( type_name: "Regular", rate_multiplier: 2, overtime_multiplier: 2.6, rest_day_multiplier: 1.3, no_work_pay: true, overtime_rest_day_multiplier: 2.6)
  specialNonWorkingHoliday = HolidayType.create( type_name: "Special Non-Working", rate_multiplier: 1.3, overtime_multiplier: 1.69, rest_day_multiplier: 1.5, no_work_pay: false, overtime_rest_day_multiplier: 1.95)
  doubleHoliday = HolidayType.create( type_name: "Double Holiday", rate_multiplier: 3.0, overtime_multiplier: 1.69, rest_day_multiplier: 1.5, no_work_pay: false, overtime_rest_day_multiplier: 1.95)

  Holiday.create( date_of_implementation: Date.new(2016,1,1) , name: "New Year's Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence)
  Holiday.create( date_of_implementation: Date.new(2016,2,8) , name: "Chinese Lunar New Year's Day", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,3,24) , name: "Maundy Thursday", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,3,25) , name: "Good Friday", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,4,9) , name: "The Day of Valor", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,5,1) , name: "Labor Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,6,12) , name: "Ninoy Aquino Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,8,21) , name: "National Heroes Day", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,8,28) , name: "National Heroes Day holiday", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,11,1) , name: "All Saints' Day", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,12,25) , name: "Christmas Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,12,30) , name: "Rizal Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2016,12,31) , name: "New Year's Eve", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )

  Holiday.create( date_of_implementation: Date.new(2015,1,1) , name: "New Year's Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence)
  Holiday.create( date_of_implementation: Date.new(2015,1,2) , name: "Special non-working day after New Year", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,2,19) , name: "Chinese Lunar New Year's Day", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,4,2) , name: "Maundy Thursday", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,4,3) , name: "Good Friday", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,4,4) , name: "Holy Saturday", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,4,9) , name: "The Day of Valor", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,5,1) , name: "Labor Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,5,12) , name: "Independence Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,8,21) , name: "Ninoy Aquino Day", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,8,30) , name: "National Heroes Day", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,8,31) , name: "National Heroes Day Holiday", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,11,1) , name: "All Saints' Day", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,11,30) , name: "Bonifacio Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,12,24) , name: "Christmas Eve", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,12,25) , name: "Christmas Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,12,30) , name: "Rizal Day", holiday_type: regularHoliday, remark: Faker::Lorem.sentence )
  Holiday.create( date_of_implementation: Date.new(2015,12,31) , name: "New Year's Eve", holiday_type: specialNonWorkingHoliday, remark: Faker::Lorem.sentence )

  # Official Branches
  north_sea = Branch.create(name: 'North Sea Cainta')
  greco = Branch.create(name: 'GRECO Warehouse')
  biofin = Branch.create(name: 'BIOFIN')
  green_terrain = Branch.create(name: 'GREEN TERRAIN')
  ampid = Branch.create(name: 'Ampid Diesel Trading')
  generic = Branch.create(name: 'Generic')

  # Telephone for Branches
  Telephone.create( remark: "Main Number 1", digits: "6451514", telephonable_type: north_sea.class ,telephonable_id: north_sea.id )
  Telephone.create( remark: "Main Number 2", digits: "6452237", telephonable_type: north_sea.class ,telephonable_id: north_sea.id )
  Telephone.create( remark: "Fax", digits: "6452246", telephonable_type: north_sea.class ,telephonable_id: north_sea.id )
  Telephone.create( remark: "Cellphone", digits: "09237354641", telephonable_type: north_sea.class ,telephonable_id: north_sea.id )
  Telephone.create( remark: "Main Number", digits: "9427048", telephonable_type: greco.class ,telephonable_id: greco.id )
  Telephone.create( remark: "Main Number", digits: "6478092", telephonable_type: biofin.class ,telephonable_id: biofin.id )

  # Addresses for Branches
  Address.create( remark: "North Sea Parts, Marcos Highway, Cainta, Rizal", longitude: 121.106819, latitude: 14.622056, addressable_type: north_sea.class ,addressable_id: north_sea.id  )
  Address.create( remark: "Greco Warehouse, Sumulong Highway, Antipolo, Rizal", longitude: 121.138520, latitude: 14.616369, addressable_type: greco.class ,addressable_id: greco.id )
  Address.create( remark: "Biofin Petshop, Sumulong Highway, Antipolo, Rizal", longitude: 121.134781, latitude: 14.617416, addressable_type: biofin.class ,addressable_id: biofin.id )

  # Digitals for Branches
  Digital.create( remark: "email", url: "northseaparts@yahoo.com", digitable_type: north_sea.class ,digitable_id: north_sea.id  )
  Digital.create( remark: "email", url: "northseaparts@gmail.com", digitable_type: north_sea.class ,digitable_id: north_sea.id )
  Digital.create( remark: "email", url: "biofinbreeding@yahoo.com.ph", digitable_type: biofin.class ,digitable_id: biofin.id )

  #Constants
  Constant.create( constant_type: 'human_resources.minimum_wage', value: '362.50', name: 'Minimum Wage', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.preferred_rest_day', value: 'SUNDAY', name: 'Preferred Rest Day', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.contract_days', value: '366', name: 'Default Duration of Contract (Days)', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.time_start', value: '08:00', name: 'Usual time Start for Employee', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.time_end', value: '17:00', name: 'Usual time End for Employee', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.night_shift_differential_start', value: '22:00', name: 'Start of Night Shift Differential', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.night_shift_differential_end', value: '05:00', name: 'End of Night Shift Differential', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.night_shift_differential_multiplier', value: '0.1', name: 'Multiplier for NSD', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.start_lunch_break', value: '12:00', name: 'Default Duration of Contract (Days)', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )
  Constant.create( constant_type: 'human_resources.end_lunch_break', value: '13:00', name: 'Default Duration of Contract (Days)', remark: nil, date_of_implementation: Time.new(1974, 04, 01) )

  #Departments
  hr = Department.new(name: "Human Resources", remark: "no remark")
  hr.save
  sales = Department.new(name: "Sales", remark: "no remark")
  sales.save
  ops = Department.new(name: "Operations", remark: "no remark")
  ops.save
  marketing = Department.new(name: "Marketing", remark: "no remark")
  marketing.save
  accfin = Department.new(name: "Accounting and Finance", remark: "no remark")
  accfin.save
  admin = Department.new(name: "Administration", remark: "no remark")
  admin.save

  #POSITIONS
  numberOfPositions = 50
  numberOfPositions.times do |i|
    departments = [hr, sales, ops, marketing, accfin, admin]
    department = departments[rand(departments.length)]
    myPosition = Position.new(remark: Faker::Lorem.words(32), name: Faker::Lorem.words(3) , department: department )
    myPosition.save
  end

end