Rails.application.routes.draw do
  devise_for :users
  devise_for :customers,    path: 'cliente',      path_names: {sign_in: 'login', sign_up: 'cadastre-se', sign_out: 'logout'}
  devise_for :consultants,  path: 'consultor',    path_names: {sign_in: 'login', sign_up: 'cadastre-se', sign_out: 'logout'}
  devise_for :admins,       path: 'admin',        path_names: {sign_in: 'login', sign_out: 'logout'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'public#index'

  get 'termos' => "public#termos", as: :termos

  get 'quemsomos' => "public#quemsomos", as: :quemsomos

  get 'contato' => "public#contato", as: :contato

  get 'admin', to: 'admin#index', as: 'admin'


  get 'add_item/:item_id', path: 'adicionar', to: 'customer/carts#add_item', as: 'add_item'
  resources :categories, path: 'categoria', only: [:show]
  resources :subcategories, path: 'subcategoria', only: [:show]
  resources :items, path: 'produto', only: [:show]

  namespace :customer , path: 'minha-conta' do

    get 'show', path: 'geral'

    resources :credentials, only: [] do
      put 'update_password', on: :collection
    end
    

    resources :account, path: 'meus-dados', only: ['edit', 'update'], path_names: {update: 'atualizar', edit: 'editar'} do
      get 'edit_address', path: 'editar-enderecos', on: :collection
      put 'update_address', on: :collection
      post 'create_address', on: :collection
      get 'new_address', path: 'novo-endereco', on: :collection
    end

    resources :carts, path: 'carrinho-de-compras' do
      get 'show', path: 'carrinho', on: :member
      post 'shipping', path: 'entrega', on: :member
      post 'freight', path: 'frete', on: :member
      post 'payment', path: 'opcoes-de-pagamento', on: :member
      collection do
        post 'remove_item', path: 'remover'
        post 'update_item', path: 'atualizar-carrinho'
        post 'payment', path: 'pagamento'
      end
    end

    resources :items, path: 'produto', only: [:show]

    resources :orders, path: 'meus-pedidos', only: [:show, :index] do
      get 'search', path: 'buscar', on: :collection
      patch 'order_delivered', on: :member
    end

    resources :orders, path: 'pedidos', only: [:index, :show] do
      post 'credit_card', path: 'carta-de-credito'
      post 'billet', path: 'boleto'
    end

  end

  namespace :admin, path: 'admin' do

    resources :categories, path: 'categorias', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end

    resources :subcategories, path: 'subcategorias', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end

    resources :items, path: 'produtos', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end

    resources :customers, path: 'clientes', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end

    resources :consultants, path: 'consultores', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end

    resources :orders, path: 'pedidos', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end
    
    resources :banners, path: 'banners', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end

    resources :app_info, path: 'app_info', path_names: {edit: 'editar', new: 'novo'} do
      get 'search', on: :collection
    end
    
  end

end
