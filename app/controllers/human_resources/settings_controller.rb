class HumanResources::SettingsController < HumanResourcesController

  def index

    @simple_clndr = Clndr.new(:simple)
    @simple_clndr.start_with_month = Time.now - 1.year

    @overview_panels = [
        [human_resources_settings_constants_path,'Constants'],
        [human_resources_settings_holidays_path,'Holidays'],
        [human_resources_settings_holiday_types_path,'Holiday Types']
    ]

    generic_index_main('Settings regarding Human Resources')

  end


end
