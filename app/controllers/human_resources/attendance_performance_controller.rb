class HumanResources::AttendancePerformanceController < HumanResourcesController

  def index

    @overview_panels = [
        [human_resources_attendance_performance_attendances_path, 'Attendances'],
        [human_resources_attendance_performance_rest_days_path, 'Rest Days']
    ]

    generic_index_main('Settings regarding Human Resources')

  end

end
