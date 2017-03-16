Rails.application.routes.draw do
  root 'board#index'
  get 'board/index'
  get 'board/drop_disc'
  get 'board/reset'
  get 'board/check_game_over'
  get 'board/get_discs'
end
