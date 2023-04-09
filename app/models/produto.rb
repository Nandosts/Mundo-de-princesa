# app/models/produto.rb
class Produto < ApplicationRecord
  validates :nome, presence: true
  validates :descricao, presence: true
  validates :preco, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantidade, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :imageUrl, presence: true
end
