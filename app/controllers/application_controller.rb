class ApplicationController < ActionController::Base
  before_action :define_produtos

  private

  def define_produtos
    @produtos = Produto.all
  end
end
