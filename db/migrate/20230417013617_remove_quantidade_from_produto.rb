class RemoveQuantidadeFromProduto < ActiveRecord::Migration[6.1]
  def change
    remove_column :produtos, :quantidade
  end
end
