# app/controllers/produtos_controller.rb

class ProdutosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @produtos = Produto.all
  end

  def new
    @produto = Produto.new
  end

  def show
    @produto = Produto.find(params[:id])
  end

  # app/controllers/produtos_controller.rb
  def create
    @produto = Produto.new(produto_params)
    if @produto.save
      begin
        image_change(@produto)
        @produto.update(imageUrl: url_for(@produto.imagem))
        # Associar a imagem ao produto
        flash.now[:notice] = "Produto criado com sucesso!"
        redirect_to @produto
      rescue => e
        flash.now[:alert] = "Alguma coisa deu errado: #{e}"
        render :new
      end
    else
      flash.now[:alert] = "Alguma coisa deu errado."
      render :new
    end
  end

  def edit
    @produto = Produto.find(params[:id])
  end

  def update
    @produto = Produto.find(params[:id])
    if @produto.update!(produto_params)
      begin
        image_change(@produto)
        @produto.update(imageUrl: url_for(@produto.imagem))
        flash.now[:notice] = "Produto atualizado com sucesso!"
        redirect_to @produto
      rescue => e
        flash.now[:alert] = "Alguma coisa deu errado: #{e}"
        render :edit
      end
    else
      flash.now[:alert] = "Alguma coisa deu errado."
      render :edit
    end
  end

  def destroy
    @produto = Produto.find(params[:id])
    @produto.destroy
    flash.now[:notice] = "Produto excluído com sucesso!"
    redirect_to produtos_path
  end

  private

  def produto_params
    params.require(:produto).permit(:id, :nome, :descricao, :preco, :imagem, :imageUrl)
  end

  def check_admin
    return if current_user&.admin?

    redirect_to root_path, alert: 'Acesso negado. Você precisa ser um administrador para realizar essa ação.'
  end

  def image_change(produto)
    imagem = params[:produto][:imagem]
    return if imagem.nil?

    produto.imagem.purge if produto.imagem.attached?
    produto.imagem.attach(imagem)
  end
end
