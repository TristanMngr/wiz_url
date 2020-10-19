Rails.application.routes.draw do
  root to: "homepages#index"

  get '/:slug', to: 'links#short', as: :short

  resources :links
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
