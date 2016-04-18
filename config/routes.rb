Rails.application.routes.draw do

  concern :generic_table do
    get :search_suggestions
  end

  get 'access/' => 'access#index'
  namespace :access do

  end

  get 'human_resources/' => 'human_resources#index'
  get 'human_resources/employee_overview_profile' => 'human_resources#employee_overview_profile'
  get 'human_resources/employee_overview_duty_status' => 'human_resources#employee_overview_duty_status'
  get 'human_resources/check_employee_name_exists' => 'human_resources#check_employee_name_exists'
  namespace :human_resources do

    get 'employee_accounts_management/' => 'employee_accounts_management#index'
    namespace :employee_accounts_management do
      get 'employee_profile/' => 'employee_profile#index'
      get 'employee_profile/index' => 'employee_profile#index'
      resources :employees, :duty_statuses, :biodata do
        collection do
          concerns :generic_table
        end
      end
    end

    get 'compensation_and_benefits/' => 'compensation_and_benefits#index'
    namespace :compensation_and_benefits do
      get 'payrolls/branches' => 'payrolls#branches'
      get 'payrolls/employee' => 'payrolls#employee'
      get 'leaves/check_leave_date_if_overlap' => 'leaves#check_leave_date_if_overlap'
      resources :lump_adjustments, :base_rates, :vales, :vale_adjustments, :institutional_adjustments, :payrolls, :payroll_settings, :leaves, :loans, :loan_payments do
        collection do
          concerns :generic_table
        end
      end
    end

    get 'attendance_performance/' => 'attendance_performance#index'
    namespace :attendance_performance do
      get '/branch_attendance_sheet' => 'branch_attendance_sheet#index'
      get '/branch_attendance_sheet/index' => 'branch_attendance_sheet#index'
      get 'attendances/check_time_if_between_attendance' => 'attendances#check_time_if_between_attendance'
      get 'attendances/check_time_if_overlap_attendance' => 'attendances#check_time_if_overlap_attendance'
      match '/branch_attendance_sheet/process_branch_attendance_sheet', to: 'branch_attendance_sheet#process_branch_attendance_sheet', via: [:post]
      resources :rest_days, :attendances, :regular_work_periods do
        collection do
          concerns :generic_table
        end
      end
    end

    get 'settings/' => 'settings#index'
    namespace :settings do
      get '/holidays/check_unique_holiday_date' => 'holidays#check_unique_holiday_date'
      resources :constants, :holidays, :holiday_types do
        collection do
          concerns :generic_table
        end
      end
    end

  end

  get 'general_administration/' => 'general_administration#index'
  namespace :general_administration do

    get 'actors/' => 'actors#index'
    get 'actor_profile/' => 'actor_profile#index'
    get 'actor_profile/index' => 'actor_profile#index'
    resources :actor do
      collection do
        concerns :generic_table
        end
    end

    get 'branches/' => 'branches#index'
    resources :branches do
        collection do
          concerns :generic_table
        end
    end

    get 'vehicles/' => 'vehicles#index'
    resources :vehicle do
      collection do
        concerns :generic_table
      end
    end

    get 'file_sets/' => 'file_sets#index'
    resources :file_sets do
      collection do
        concerns :generic_table
      end
    end

    get 'image_sets/' => 'image_sets#index'
    resources :image_set do
      collection do
        concerns :generic_table
      end
    end

    get 'link_sets/' => 'link_sets#index'
    resources :link_set do
      collection do
        concerns :generic_table
      end
    end

    get 'telephones/' => 'telephones#index'
    resources :telephones do
      collection do
        concerns :generic_table
      end
    end

    get 'addresses/' => 'addresses#index'
    resources :addresses do
      collection do
        concerns :generic_table
      end
    end

    get 'digitals/' => 'digitals#index'
    resources :digitals do
      collection do
        concerns :generic_table
        get :search
      end
    end



  end

  get 'access/' => 'access#index'
  namespace :access do
    get 'permissions/index' => 'permissions#index'
    resources :permissions do
      collection do
        concerns :generic_table
      end
    end

    get 'accesses/index' => 'accesses#index'
    resources :accesses do
      collection do
        concerns :generic_table
      end
    end
  end

  get 'finance/' => 'finance#index'
  namespace :finance do
    get 'expenses/index' => 'expenses#index'
    resources :expenses do
      collection do
        concerns :generic_table
      end
    end
  end

  get 'application/reset_search' => 'application#reset_search'

  resources :test, only: :index
  root to: 'home#index'
  match ':controller(/:action(/:id))', :via => [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/e:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
