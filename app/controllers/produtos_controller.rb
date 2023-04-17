# app/controllers/produtos_controller.rb

class ProdutosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_produto, only: %i[show edit update destroy]

  def index
    @produtos = Produto.all
  end

  def new
    @produto = Produto.new
  end

  def show
  end

  def create
    @produto = Produto.new(produto_params)
    if @produto.save
      begin
        unless params[:produto][:imagem].nil?
          image_change(@produto)
          @produto.update(imageUrl: url_for(@produto.imagem))
        end
        flash.now[:notice] = 'Produto criado com sucesso!'
        redirect_to @produto
      rescue StandardError => e
        flash.now[:alert] = "Alguma coisa deu errado: #{e}"
        render :new
      end
    else
      flash.now[:alert] = "Alguma coisa deu errado. #{@produto.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @produto.update(produto_params)
      begin
        unless params[:produto][:imagem].nil?
          image_change(@produto)
          @produto.update(imageUrl: url_for(@produto.imagem))
        end
        flash.now[:notice] = 'Produto atualizado com sucesso!'
        redirect_to @produto
      rescue StandardError => e
        flash.now[:alert] = "Alguma coisa deu errado: #{e}"
        render :edit
      end
    else
      flash.now[:alert] = "Alguma coisa deu errado. #{@produto.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    @produto.destroy
    flash.now[:notice] = 'Produto excluído com sucesso!'
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

  def set_produto
    @produto = Produto.find(params[:id])
  end
end
