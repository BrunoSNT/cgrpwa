Rails.application.routes.draw do
  resources :repays
  resources :extracts
  resources :payments
  resources :deals
  get 'money_flow' => 'extracts#money_flow'
  get 'negs_history', to: 'deals#history_index'
  resources :quotes
  resources :documents
  resources :setups
  resources :notifications
  get 'toggle_status_entregue/:id' => 'orders#toggle_status_entregue', as: "toggle_entregue"
  get 'toggle_status_pendente/:id' => 'orders#toggle_status_pendente', as: "toggle_pendente"
  get 'toggle_status_sim/:id' => 'items#toggle_status_sim', as: "toggle_sim"
  get 'toggle_status_nao/:id' => 'items#toggle_status_nao', as: "toggle_nao"
  get 'update_deal_status/:id/:status' => 'deals#update_deal_status', as: "update_deal_status"
  get 'update_payment_status/:id/:status' => 'payments#update_payment_status', as: "update_payment_status"
  get 'update_repay_status/:id/:status' => 'repays#update_repay_status', as: "update_repay_status"
  resources :orders
  resources :items
  get 'recompensas' => 'stores#index', as: "store"
  get 'torredevendas' => 'negociators#index', as: "sales_tower"
  get 'minhasnegociacoes' => 'negociators#negotiations', as: "my_sales"
  get 'reembolsos' => "main#reembolsos", as: "reembolsos"
  resources :goals
  resources :did_goods
  resources :hours, only: [:index, :create]
  resources :roles
  resources :projects
  resources :diretor_projects
  resources :occupations
  resources :cores
  resources :activities
  resources :user_activities
  resources :activity_categories
  devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
  }
  get '/redirect', to: 'google_agenda#redirect', as: 'redirect'
  get '/callback', to: 'google_agenda#callback', as: 'callback'
  get '/calendars', to: 'google_agenda#calendars', as: 'calendars'
  get '/agendas', to: 'google_agenda#index', as: 'agendas'
  get '/events/:calendar_id', to: 'google_agenda#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'google_agenda#new_event', as: 'new_event', calendar_id: /[^\/]+/
  get '/att_saw_did_good', to: "main#att_saw_did_good"
  get '/att_saw_notifications', to: "main#att_sawnotifications"
  get '/dashboardhoras', to: "hours#hours_dashboard", as: "dashboard_hours"
  get '/seuspedidos', to: "orders#user_orders", as: "pedidos"
  get '/superdidgood', to: "did_goods#new_superdidgood", as: "superdidgood"
  root to: "main#index"
  get 'wallet', to: "main#wallet", as: "wallet"


  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resources :did_goods, only: [:index,:create], controller: :did_goods
    get '/did_goods_received' => 'did_goods#did_goods_received'
    get '/did_goods_sent' => 'did_goods#did_goods_sent'
    get '/receivers', to: 'did_goods#get_users', as: 'get_users'
    get '/ranking_received' => 'did_goods#ranking_received'
    get '/ranking_sent' => 'did_goods#ranking_sent'
    get '/profile' => 'did_goods#myself'

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
