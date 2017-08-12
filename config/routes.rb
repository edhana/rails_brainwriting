Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'ideas#index', as: 'home'
  get 'board/:name' => 'ideas#newboard', as: 'new_board'
  get 'idea/:parent_id/new' => 'ideas#new', as: 'new_child'
  resources :ideas
end
