# db/migrate/20230409220414_create_produtos.rb
class CreateProdutos < ActiveRecord::Migration[6.1]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.string :descricao
      t.decimal :preco, precision: 10, scale: 2
      t.integer :quantidade
      t.string :imageUrl

      t.timestamps
    end
  end
end
