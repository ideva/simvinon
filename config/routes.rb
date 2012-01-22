SIMVerifikasiEJKBM_RS::Application.routes.draw do
  get "settings/index"

  resources :mapping_pelayanan_lains

  resources :pelayanan_lains

  resources :verifikasi_pelayanan_lains

  resources :jenis_pelayanans

  resources :kabupatens

  resources :test_plants

  resources :alasan_verifikasis

  resources :verifikasis

  resources :pemeriksaans

  resources :obats

  resources :kategori_obats

  resources :mapping_data_tindakan_penunjangs

  resources :mapping_data_tindakan_medis

  resources :mapping_data_pemeriksaans

  resources :mapping_data_obats

  resources :tindakan_medis

  resources :kategori_tindakan_medis

  resources :tindakan_penunjangs

  resources :kategori_tindakan_penunjangs

  resources :settings

  get "general/index"

  get "main/index"
  match 'panel' => 'main#index_admin', :as => :panel

  resources :users

  resource :session, :only => [:new, :create, :destroy]

  match 'signup' => 'users#new', :as => :signup
  match 'register' => 'users#create', :as => :register
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil
  match '/forgot' => 'users#forgot'
  match 'reset/:reset_code' => 'users#reset'

  resources :functions

  resources :user_types


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
