# app/controllers/produtos_controller.rb

class ProdutosController < ApplicationController
  def index
    @produtos = Produto.all
  end

  def new
    @produto = Produto.new
  end

  def create
    @produto = Produto.new(produto_params)
    if @produto.save
      redirect_to produtos_path, notice: 'Produto criado com sucesso!'
    else
      render :new
    end
  end

  def edit
    @produto = Produto.find(params[:id])
  end

  def update
    @produto = Produto.find(params[:id])
    if @produto.update(produto_params)
      redirect_to produtos_path, notice: 'Produto atualizado com sucesso!'
    else
      render :edit
    end
  end

  def destroy
    @produto = Produto.find(params[:id])
    @produto.destroy
    redirect_to produtos_path, notice: 'Produto excluído com sucesso!'
  end

  private

  def produto_params
    params.require(:produto).permit(:id, :nome, :descricao, :preco, :quantidade, :imageUrl)
  end
end
