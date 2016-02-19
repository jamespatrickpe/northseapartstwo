# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
        permission.access = myAccess
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

  #Related Link Sets
  rand(0..10).times do |i|
    if randomBoolean
      myLinkSet = LinkSet.new
      myLinkSet.label = Faker::Lorem.word
      myLinkSet[:url] = Faker::Lorem.word
      myLinkSet.rel_link_set_id = myActor.id
      myLinkSet.rel_link_set_type = 'Actor'
      myLinkSet.save!
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


    # For Expenses
    randomNumberOfExpenses = rand(0..30)
    randomNumberOfExpenses.times do |i|
      expense = Expense.new()
      expense.amount = randomMoney(100.10, 1000.00)
      expense.category = Faker::Lorem.word
      expense.remark = Faker::Lorem.sentence
      expense.date_of_effectivity = rand(720..72000).hours.ago
      expense.physical_id = Faker::Lorem.word
      expense.save!
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