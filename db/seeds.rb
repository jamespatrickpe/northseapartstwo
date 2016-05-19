include ApplicationHelper
require File.expand_path('../official_starter_seed', __FILE__)
puts " == Loading Seed Data =="

#  ----------------------------------------------------------------------------------- RANDOM SEED DATA ------------------------------------------------------------------------

def randomBoolean()
  return [true, false].sample
end

def randomMoney( lower, upper)
  return rand(lower..upper)
end

# ENTITIES

# SystemActor Dependent Systems
numberOfSystemActors = 20
numberOfSystemActors.times do |i|

  #SystemActor
  current_logo = ['default_1.jpg','default_2.jpg','default_3.jpg','default_4.jpg','default_5.jpg','default_6.jpg','default_7.jpg','default_8.jpg','default_9.jpg','default_10.jpg','default.jpg'].sample
  mySystemActor = SystemActor.new(name: Faker::Name.name , remark: Faker::Lorem.sentence(3, true))
  mySystemActor[:logo] = current_logo
  mySystemActor.save!

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
    myAccess.system_actor = mySystemActor
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
        permission.access = myAccess
        permission.can = ['access_control','assess_vale','human_resources'].sample
        permission.remark =  Faker::Lorem.sentence
        permission.save!
      end
    end
  end

  # BIODATA
  if(randomBoolean())
    myBioData = Biodatum.new()
    myBioData.system_actor = mySystemActor
    myBioData.education = ["Elementary", "High School", "College Undergraduate", "College Graduate - Bachelor", "College Graduate - Master", "College Graduate - Doctor"].sample
    myBioData.career_experience = Faker::Lorem.sentence(3, false, 4)
    myBioData.notable_accomplishments = Faker::Lorem.sentence(3, false, 4)
    myBioData.date_of_birth = Faker::Date.between(600.months.ago, 216.months.ago)
    myBioData.family_members = Faker::Lorem.sentence(3, false, 4)
    myBioData.citizenship = Faker::Address.country
    myBioData.gender = ["Male", "Female"].sample
    myBioData.place_of_birth = Faker::Address.city
    myBioData.emergency_contact = Faker::PhoneNumber.phone_number
    myBioData.languages_spoken = Faker::Lorem.sentence(3, false, 4)
    myBioData.complexion = ["Light", "Fair", "Medium", "Dark"].sample
    myBioData.height_cm = Faker::Number.number(3)
    myBioData.marital_status = ["Single", "Married", "Widowed", "Divorced"].sample
    myBioData.blood_type = ["O -", "O +", "A -", "A +", "B -", "B +", "AB -", "AB +"].sample
    myBioData.religion = Faker::Lorem.sentence(3, false, 4)
    myBioData.save
  end

  # Human Resources
  if 80.in(100)
    # ids = Branch.pluck(:id).shuffle
    # myBranch = Branch.where(id: ids)
    myEmployee = Employee.new( system_actor: mySystemActor, branch: Branch.all.shuffle.first )

    #Attendances
    rand(20..50).times do |i|
      myDate = DateTime.now - i.days
      dateOfAttendance = Date.new(myDate.year , myDate.month, myDate.day)
      # timein = Time.new( myDate.year , myDate.month, myDate.day, (0..12), rand(0..59), rand(0..59) )
      # timeout = Time.new( myDate.year , myDate.month, myDate.day, rand(12..23), rand(0..59), rand(0..59) )
      time_in = rand(0..12).to_s+':'+rand(0..59).to_s+':'+rand(0..59).to_s
      time_out = rand(12..23).to_s+':'+rand(0..59).to_s+':'+rand(0..59).to_s
      remark = Faker::Lorem.word
      if 10.in(100)
        myAttendance = Attendance.new(date_of_implementation: dateOfAttendance, timein: time_in, employee: myEmployee, remark: remark )
        myAttendance.save
        time_out = rand(0..12).to_s+':'+rand(0..59).to_s+':'+rand(0..59).to_s
        myAttendance = Attendance.new(date_of_implementation: dateOfAttendance + 1.day, timeout: time_out, employee: myEmployee, remark: remark )
        myAttendance.save
        myDate = myDate + 1.days
      elsif 10.in(100)
        myDate = myDate - rand(1..10).days
      elsif 70.in(100)
        myAttendance = Attendance.new(date_of_implementation: dateOfAttendance, timein: "08:00:00", timeout: "17:00:00", employee: myEmployee, remark: remark )
        myAttendance.save
      else
        myAttendance = Attendance.new(date_of_implementation: dateOfAttendance, timein: time_in, timeout: time_out, employee: myEmployee, remark: remark )
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
    restday.datetime_of_implementation = rand(720..72000).hours.ago
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
      work_period = RegularWorkPeriod.new(remark: Faker::Lorem.word,
                                         employee: myEmployee,
                                         start_time: start_time,
                                         end_time: end_time )
      work_period.datetime_of_implementation = rand(720..72000).hours.ago
      work_period.save!
    end

    rand(0..5).times do
      dutyStatus = DutyStatus.new(remark: Faker::Lorem.sentence, employee: myEmployee)
      if 5.in(10)
        active = -> { true }
      else
        active = -> { false }
      end
      dutyStatus.active = active.call
      dutyStatus.datetime_of_implementation = rand(720..72000).hours.ago
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
      myBaseRate = BaseRate.new(remark: Faker::Lorem.sentence(4),
                                amount: amountOfMoney,
                                period_of_time: periodOfTime,
                                employee: myEmployee,
                                start_of_effectivity: Faker::Time.between(Time.now, Time.now - 300.days, :all),
                                end_of_effectivity: Faker::Time.between(Time.now + 300.days, Time.now, :all),
                                rate_type: ['BASE', 'ALLOWANCE', 'OTHER'].sample
      )
      myBaseRate.save
    end

    # For Lump Adjustment
    numberOfDuties = rand(1..5)
    numberOfDuties.times do
      dutyStatus = DutyStatus.new(remark: Faker::Lorem.sentence, employee: myEmployee)
      active = -> { [false,true].sample }
      dutyStatus.active = active.call
      dutyStatus.datetime_of_implementation = rand(720..72000).hours.ago
      dutyStatus.save!
    end

    # Loans
    # rand(0..1).times do |i|
    #   myLoan = Loan.new()
    #   myLoan.loan_type = ['SSS','PHILHEALTH','PAGIBIG'].sample
    #   myLoan.pagibig_employer_id_number = '123456'
    #   myLoan.employee_id = myEmployee.id
    #   myLoan.borrower_name = myEmployee.system_actors.name
    #   myLoan.loan_value = 1000000
    #   myLoan.loan_remaining = 1000000
    #   myLoan.collection_period_from = Time.now - rand(0..72000).hours
    #   myLoan.collection_period_to = Time.now - rand(0..72000).hours
    #   myLoan.monthly_installment = randomMoney(300.10,1000.00)
    #   myLoan.save!
    # end

    # # Loans Payment
    # rand(0..10).times do |i|
    #   myLoanPayment = LoanPayment.new()
    #   myLoanPayment.loan_id = Faker::Lorem.word
    #   myLoanPayment.mid_number = '123456'
    #   myLoanPayment.payment_amount = randomMoney(500.10,1000.00)
    #   myLoanPayment.payment_date = Time.now - rand(0..72000).hours
    #   myLoanPayment.loan_amount_before_payment = randomMoney(500.10,1000.00)
    #   myLoanPayment.loan_amount_after_payment = randomMoney(500.10,1000.00)
    #   myLoanPayment.remark = Faker::Lorem.sentence
    #   myLoanPayment.save!
    # end

    randomNumberOfLumpAdjustment = rand(0..30)
    randomNumberOfLumpAdjustment.times do |i|
      lumpAdjustment = LumpAdjustment.new()
      lumpAdjustment.amount = randomMoney(100.10,1000.00)
      lumpAdjustment.employee = myEmployee
      lumpAdjustment.remark = Faker::Lorem.word
      lumpAdjustment.datetime_of_implementation = rand(720..72000).hours.ago
      lumpAdjustment.save!
    end


    # For Expenses
    randomNumberOfExpenses = rand(0..5)
    randomNumberOfExpenses.times do |i|
      expense = Expense.new()
      expense.amount = randomMoney(100.10, 1000.00)
      expense.category = ["utilities.gas","utilities.electricity","utilities.water","utilities.telephone"].sample
      expense.remark = Faker::Lorem.sentence
      expense.datetime_of_implementation = rand(720..72000).hours.ago
      expense.physical_id = Faker::Lorem.word
      expense.save!
    end

    # For Payroll
    rand(0..2).times do |i|

      if 9.in(10)
        my_payroll_settings = PayrollSetting.new
        boolean_of_applicability = -> { [false,true].sample }
        my_payroll_settings.SSS_ID = Faker::Code.ean
        my_payroll_settings.PHILHEALTH_ID = Faker::Code.ean
        my_payroll_settings.PAGIBIG_ID = Faker::Code.ean
        my_payroll_settings.BIR_ID = Faker::Code.ean
        my_payroll_settings.SSS_status = boolean_of_applicability
        my_payroll_settings.PHILHEALTH_status = boolean_of_applicability
        my_payroll_settings.PAGIBIG_status = boolean_of_applicability
        my_payroll_settings.BIR_status = boolean_of_applicability
        my_payroll_settings.datetime_of_implementation = rand(720..72000).hours.ago
        my_payroll_settings.remark = Faker::Lorem.word
        my_payroll_settings.employee = myEmployee
        my_payroll_settings.save!
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
        my_vale.period_of_time = ['MONTH','DAY','WEEK','YEAR'].sample
        my_vale.remark = Faker::Lorem.word
        my_vale.datetime_of_implementation = rand(720..72000).hours.ago
        my_vale.save!
        if 5.in(10)
          rand(1..3).times do |i|
          my_vale_adjustment = ValeAdjustment.new
          my_vale_adjustment.vale = my_vale
          my_vale_adjustment.amount = randomMoney(10.10,250.00)
          my_vale_adjustment.remark = Faker::Lorem.word
          my_vale_adjustment.datetime_of_implementation = rand(720..72000).hours.ago
          my_vale_adjustment.save!
          end
        end
      end
    end

  end
end

# General Administration

# Vehicles
rand(20..50).times do |b|
  myVehicle = Vehicle.new
  myVehicle.type_of_vehicle = ['Sedan','Truck','Delivery','Van','SUV'].sample
  myVehicle.plate_number = Faker::Lorem.characters(6).upcase
  myVehicle.orcr = Faker::Lorem.word
  myVehicle.capacity_m3 = Faker::Number.between(1, 10)
  myVehicle.remark = Faker::Lorem.sentence
  myVehicle.save!
end

def random_contactable_model
  associative_model = Hash.new
  random_model = [SystemActor,Branch].sample
  associative_model[:my_model] = random_model
  associative_model[:my_model_id] = random_model.order("RAND()").first.id
  associative_model
end

def random_fileable_model
  associative_model = Hash.new
  random_model = [SystemActor,Branch].sample
  associative_model[:my_model] = random_model
  associative_model[:my_model_id] = random_model.order("RAND()").first.id
  associative_model
end

def random_associable_model
  my_model = Hash.new
  models_array = [SystemActor,Branch,Vehicle]
  my_model[:current_model] = models_array.sample
  my_model[:current_id] = my_model[:current_model].order("RAND()").first.id
  my_model
end

# Related File Sets
rand(20..50).times do |i|
  sample = random_fileable_model
  myFileSet = FileSet.new
  chosen_file = ['export_table_1.csv','export_table_2.csv','export_table_3.csv','export_table_4.csv','export_table_5.csv'].sample
  myFileSet[:file] = chosen_file
  myFileSet.remark = Faker::Lorem.sentence
  myFileSet.physical_storage = Faker::Lorem.word
  myFileSet.filesetable_id = sample[:my_model_id]
  myFileSet.filesetable_type = sample[:my_model]
  myFileSet.save!
end

# Related Image Sets
rand(20..50).times do |i|
  sample = random_fileable_model
  myImageSet = ImageSet.new
  chosen_file = ['file_01.jpg','file_02.jpg','file_03.gif','file_04.jpg','file_05.jpg'].sample
  myImageSet[:picture] = chosen_file
  myImageSet.priority = rand(1..20)
  myImageSet.remark = Faker::Lorem.sentence
  myImageSet.imagesetable_id = sample[:my_model_id]
  myImageSet.imagesetable_type = sample[:my_model]
  myImageSet.save!
end

# Related Link Sets
rand(20..50).times do |i|
  sample = random_fileable_model
  myLinkSet = LinkSet.new
  myLinkSet.remark = Faker::Lorem.word
  myLinkSet[:url] = Faker::Internet.url
  myLinkSet.linksetable_id = sample[:my_model_id]
  myLinkSet.linksetable_type = sample[:my_model]
  myLinkSet.save!
end

# Related Associative Sets
rand(20..50).times do |i|

  sample_one = random_associable_model
  sample_two = random_associable_model
  mySystemAssociation = SystemAssociation.new
  mySystemAssociation.model_one_type = sample_one[:current_model]
  mySystemAssociation.model_one_id = sample_one[:current_id]
  mySystemAssociation.model_two_type = sample_two[:current_model]
  mySystemAssociation.model_two_id = sample_two[:current_id]
  mySystemAssociation.remark = Faker::Lorem.word
  mySystemAssociation.save!

end

# Digital
rand(30..50).times do |i|
  sample = random_contactable_model
  myDigital = Digital.new( remark: Faker::Lorem.sentence, url: Faker::Internet.url)
  myDigital[:digitable_id] = sample[:my_model_id]
  myDigital[:digitable_type] = sample[:my_model]
  myDigital.save!
end

# Telephony
rand(30..50).times do |i|
  sample = random_contactable_model
  myTelephony = Telephone.new( remark: Faker::Lorem.sentence, digits: Faker::PhoneNumber.phone_number)
  myTelephony[:telephonable_id] = sample[:my_model_id]
  myTelephony[:telephonable_type] = sample[:my_model]
  myTelephony.save!
end

# Addresses
rand(30..50).times do |i|
  sample = random_contactable_model
  completeAddress = Faker::Address.building_number + ' '+ Faker::Address.street_name + ' ' + Faker::Address.street_address + ' ' + Faker::Address.city + ' ' + Faker::Address.country
  myAddress = Address.new( remark: completeAddress, longitude: Faker::Address.longitude, latitude: Faker::Address.latitude)
  myAddress[:addressable_id] = sample[:my_model_id]
  myAddress[:addressable_type] = sample[:my_model]
  myAddress.save!
end