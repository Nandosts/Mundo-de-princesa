class CarrinhoController < ApplicationController
  def adiciona_produto_no_carrinho
    flash.now[:notice] = 'YEEEEEY'
    produto = params[:produto]
    if session[:cart].is_a?(Array)
      if session[:cart].include?(produto)
        flash.now[:alert] = 'Este produto já está incluído no carrinho.'
      else
        session[:cart] << produto
        flash.now[:notice] = 'Produto adicionado ao carrinho com sucesso!'
      end
    else
      session[:cart] = [produto]
    end
    respond_to do |format|
      # Substitua :carrinho/carrega_carrinho pelo nome do template que você deseja renderizar
      format.html do
        render 'carrinho/carrega_carrinho'
      end
      format.json { render json: { notice: flash.now[:notice], alert: flash.now[:alert] } }
    end
  end

  def carrega_carrinho
    # flash.now[:notice] = "Oi"
    @cart = session[:cart]
    respond_to do |format|
      format.html
      format.json { render json: @cart }
    end
  end

  def remove_item_do_carrinho
    flash.now[:notice] = 'tchau'
    produto = params[:produto]
    if session[:cart].is_a?(Array) && session[:cart].include?(produto)
      session[:cart].delete(produto)
      flash.now[:notice] = 'Produto removido do carrinho com sucesso!'
    else
      flash.now[:alert] = 'Este produto não está incluído no carrinho.'
      respond_to do |format|
        # Substitua :carrinho/carrega_carrinho pelo nome do template que você deseja renderizar
        format.html do
          render 'carrinho/carrega_carrinho', notice: flash.now[:notice], alert: flash.now[:alert]
        end
        format.json { render json: { alert: flash.now[:alert] } }
      end
    end
  end
end
