Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :employees, only: [:index]

      resources :departments, only: [] do
        collection do
          get ':dept_no/active_employees', to: "departments#active_employees"
        end
      end
    end
  end
end
