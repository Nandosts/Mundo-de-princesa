Rails.application.routes.draw do
  post 'carrinho/adiciona_produto_no_carrinho'
  get 'carrinho', to: 'carrinho#carrega_carrinho'
  get 'home/index', to: 'home#index'
  root 'home#index'
end
