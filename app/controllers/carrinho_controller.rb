class CarrinhoController < ApplicationController
  def adiciona_produto_no_carrinho(produto)
    if session[:cart].is_a?(Array)
      session[:cart] << produto
    else
      session[:cart] = [produto]
    end
  end

  def carrega_carrinho
    @cart = [
      { nome: 'Produto 1', preco: 1000.12, quantidade: 0, imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg' },
      { nome: 'Produto 2', preco: 2000.0, quantidade: 0, imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg' },
      { nome: 'Produto 3', preco: 3000.0, quantidade: 0, imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg' },
      { nome: 'Produto 4', preco: 4000.0, quantidade: 0, imageUrl: 'https://i.stack.imgur.com/GsDIl.jpg' }
    ]
  end
end
