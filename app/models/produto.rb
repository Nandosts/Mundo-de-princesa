# app/models/produto.rb
class Produto < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :nome, presence: true
  validates :preco, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :imagem, presence: true
  has_one_attached :imagem
  after_commit :atualizar_url_imagem, on: %i[create update], if: -> { imageUrl.blank? }

  def atualizar_url_imagem
    # Verifica se a imagem foi anexada
    return unless imagem.attached? && imagem.blob.persisted?

      # Atualiza o atributo 'imageUrl' com a URL da imagem anexada
      update(imageUrl: url_for(imagem))
  end
end
