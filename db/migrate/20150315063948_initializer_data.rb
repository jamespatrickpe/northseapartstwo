class InitializerData < ActiveRecord::Migration
  def change

    #Human Resources
    holidayType = HolidayType.create( type: "Regular Holiday", additional_rate: 2.00, additional_rate_overtime: 1.30, additional_rate_rest_day_priveleges: 1.3, no_work_pay: true)
    holidayType = HolidayType.create( type: "Special Non Working Holiday", additional_rate: 1.3, additional_rate_overtime: 1.30, additional_rate_rest_day_priveleges: 1.5, no_work_pay: false)

    Holiday.create( date_of_implementation: Date.strptime('03-02-2001', '%d-%m-%Y') , name: "New Year's Day" )
    Holiday.create( date_of_implementation: , name: "Chinese Lunar New Year's Day" )
    Holiday.create( date_of_implementation: , name: "Maundy Thursday" )
    Holiday.create( date_of_implementation: , name: "Good Friday" )
    Holiday.create( date_of_implementation: , name: "The Day of Valor" )
    Holiday.create( date_of_implementation: , name: "Labor Day" )
    Holiday.create( date_of_implementation: , name: "Ninoy Aquino Day" )
    Holiday.create( date_of_implementation: , name: "National Heroes Day" )
    Holiday.create( date_of_implementation: , name: "National Heroes Day holidayy" )
    Holiday.create( date_of_implementation: , name: "All Saints' Day" )
    Holiday.create( date_of_implementation: , name: "Christmas Day" )
    Holiday.create( date_of_implementation: , name: "Rizal Day" )
    Holiday.create( date_of_implementation: , name: "New Year's Eve" )

  end
end
