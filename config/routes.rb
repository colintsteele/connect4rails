Rails.application.routes.draw do
  root 'board#index'
  get 'board/index'
  get 'board/drop_disc'
  get 'board/reset'
  get 'board/check_game_over'
  get 'board/discs'
  get 'computer/make_move'
end
