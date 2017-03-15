Rails.application.routes.draw do
  root 'board#index'

  get 'board/index'
  get 'board/drop_disc'
end
