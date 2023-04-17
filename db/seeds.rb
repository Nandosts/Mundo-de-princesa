# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rails.application.routes.default_url_options[:host] = 'mundo-de-princesa-production.up.railway.app' # Altere para o host do seu aplicativo

User.create(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  admin: ENV['ADMIN_ROLE'] == 'admin'
)

(1..5).each do |_i|
  # Crie um produto
  lacinho1 = Produto.create(nome: 'Lacinho 1', descricao: 'Descrição do Lacinho 1', preco: 9.99)

  # Anexe uma imagem ao produto
  lacinho1.imagem.attach(
    io: File.open('app/assets/images/LacinhosExemplo/amarelo e verde.webp'),
    filename: 'imagem.webp', # Nome do arquivo da imagem
    content_type: 'image/webp' # Tipo de conteúdo da imagem
  )

  # Crie mais produtos com imagens, se necessário
  lacinho2 = Produto.create(nome: 'Lacinho 2', descricao: 'Descrição do Lacinho 2', preco: 19.99)
  lacinho2.imagem.attach(
    io: File.open('app/assets/images/LacinhosExemplo/listradinho.webp'), # Caminho para a imagem no sistema de arquivos
    filename: 'listradinho.webp',
    content_type: 'image/webp'
  )

  lacinho3 = Produto.create(nome: 'Lacinho 3', descricao: 'Descrição do Lacinho 3', preco: 29.99)
  lacinho3.imagem.attach(
    io: File.open('app/assets/images/LacinhosExemplo/vermelho.webp'), # Caminho para a imagem no sistema de arquivos
    filename: 'vermelho.webp',
    content_type: 'image/webp'
  )
end
