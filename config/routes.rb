Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'
  get 'welcome/drop_disc'
end
