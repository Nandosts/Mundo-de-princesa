Rails.application.routes.draw do
  post 'carrinho/adiciona_produto_no_carrinho', to: 'carrinho#adiciona_produto_no_carrinho'
  post 'carrinho/remove_item_do_carrinho', to: 'carrinho#remove_item_do_carrinho'
  get 'carrinho', to: 'carrinho#carrega_carrinho'
  get 'home/index', to: 'home#index'
  root 'home#index'
end
