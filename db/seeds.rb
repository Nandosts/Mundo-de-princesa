# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Produto.create(nome: 'Produto 2', descricao: 'Descrição 1', preco: 1000.3123, quantidade: 10)

User.create(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  admin: ENV['ADMIN_ROLE'] == 'admin'
)
