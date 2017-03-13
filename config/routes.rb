Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  get 'welcome/mytest'
end
