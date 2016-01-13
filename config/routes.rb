Rails.application.routes.draw do

  concern :generic_table do
    get :search_suggestions
  end

  get 'human_resources/' => 'human_resources#index'
  namespace :human_resources do

    get 'employee_accounts_management/' => 'employee_accounts_management#index'
    namespace :employee_accounts_management do
      get 'employee_profile/' => 'employee_profile#index'
      get 'employee_profile/index' => 'employee_profile#index'
      resources :employees, :duty_statuses do
        collection do
          concerns :generic_table
        end
      end
    end

    get 'compensation_and_benefits/' => 'compensation_and_benefits#index'
    namespace :compensation_and_benefits do
      resources :lump_adjustments, :base_rates, :vales, :vale_adjustments, :institutional_adjustments do
        collection do
          concerns :generic_table
        end
      end
    end

    get 'attendance_performance/' => 'attendance_performance#index'
    namespace :attendance_performance do
      get '/branch_attendance_sheet' => 'branch_attendance_sheet#index'
      get '/branch_attendance_sheet/index' => 'branch_attendance_sheet#index'
      match '/branch_attendance_sheet/process_branch_attendance_sheet', to: 'branch_attendance_sheet#process_branch_attendance_sheet', via: [:post]
      resources :rest_days, :attendances, :regular_work_periods do
        collection do
          concerns :generic_table
        end
      end
    end

    get 'settings/' => 'settings#index'
    namespace :settings do
      resources :constants, :holidays, :holiday_types do
        collection do
          concerns :generic_table
        end
      end
    end

  end

  get 'general_administrator/' => 'general_administrator#index'
  namespace :general_administrator do

    get 'actor/' => 'actor#index'
    get 'actor_profile/' => 'actor_profile#index'
    get 'actor_profile/index' => 'actor_profile#index'
    resources :actor do
      collection do
        concerns :generic_table
        end
    end

    get 'branch/' => 'branch#index'
    resources :branch do
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
