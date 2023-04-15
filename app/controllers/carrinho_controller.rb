class CarrinhoController < ApplicationController
  def adiciona_produto_no_carrinho
    produto = params[:produto]
    if session[:cart].is_a?(Array)
      if session[:cart].include?(produto)
        flash[:error] = 'Este produto já está incluído no carrinho.'
      else
        session[:cart] << produto
        flash[:success] = 'Produto adicionado ao carrinho com sucesso!'
      end
    else
      session[:cart] = [produto]
    end
    redirect_to action: :carrega_carrinho
  end

  def carrega_carrinho
    @cart = session[:cart]
  end

  def remove_item_do_carrinho
    produto = params[:produto]
    if session[:cart].is_a?(Array) && session[:cart].include?(produto)
      session[:cart].delete(produto)
      flash[:success] = 'Produto removido do carrinho com sucesso!'
    else
      flash[:error] = 'Este produto não está incluído no carrinho.'
    end
    redirect_to action: :carrega_carrinho
  end
end
