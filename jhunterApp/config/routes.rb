Rails.application.routes.draw do
  root 'sessions#new'
  post '/' => 'sessions#create'
  #criar um novo usuário
  get '/usuarios/signup' => 'user#new'
  post '/usuarios/signup' => 'user#create'

  #criar um novo usuário
  get '/empresas/signup' => 'empresas#new'
  post '/empresas/signup' => 'empresas#create'

  #redireciona para a pagina inicial
  get '/indexuser' => 'user#show'
  get '/indexempresa' => 'empresas#show'
  post 'indexempresa' => 'empresas#show'
  #criar um novo usuário
  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  post '/empresas/inserir_vaga' => 'empresas#inserir_vaga'
  post '/usuarios/inserir_interesse' => 'user#inserir_interesse'
  post '/usuarios/atualiza_status_vaga' => 'user#atualiza_status_vaga'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

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
