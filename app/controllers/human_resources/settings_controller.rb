class HumanResources::SettingsController < HumanResourcesController

  def index

    @overview_panels = [
        [human_resources_settings_constants_path,'Constants'],
        [human_resources_settings_holidays_path,'Holidays'],
        [human_resources_settings_holiday_types_path,'Holiday Types']
    ]

    generic_index_main('Settings regarding Human Resources')

  end


end
