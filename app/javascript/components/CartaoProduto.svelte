<script lang="ts" context="module">
  import axios from "axios";
  import { showToast } from "./flashMessage";
  export type TProduto = {
    id: string;
    nome: string;
    descricao: string;
    preco: string;
    quantidade: number;
    imageUrl: string;
  };

  export let id = "1";
  export let nome = "Produto";
  export let descricao = "Produto";
  export let preco = "99.99";
  export let quantidade = 1;
  export let imageUrl = "https://via.placeholder.com/150";
</script>

<script lang="ts">
  export let produto: TProduto = {
    id: "1",
    nome: "Produto",
    descricao: "Produto",
    preco: "99.99",
    quantidade: 1,
    imageUrl: "https://via.placeholder.com/150",
  };

  // Importar o pacote Axios

  // Função para adicionar ao carrinho usando Axios
  function adicionarAoCarrinho() {
    const csrfTokenElement = document.getElementsByName("csrf-token")[0] as
      | HTMLMetaElement
      | undefined;
    const csrfToken = csrfTokenElement?.content || "";

    // Configurar cabeçalhos da requisição
    const headers = {
      "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken,
    };

    // Fazer a requisição POST usando Axios
    axios
      .post("/carrinho/adiciona_produto_no_carrinho", { produto }, { headers })
      .then((response) => {
        showToast("Produto adicionado ao carrinho com sucesso!", "#009688");
      })
      .catch((error) => {
        showToast("Erro ao adicionar produto ao carrinho", "#f44336");
      });
  }
</script>

<div class="product-card">
  <img
    src={produto.imageUrl || imageUrl}
    alt={produto.nome || nome}
    class="product-card__image"
  />
  <h2 class="product-card__title">{produto.nome || nome}</h2>
  <p class="product-card__price">
    {"R$" + parseFloat(produto.preco || preco).toFixed(2)}
  </p>
  <button class="product-card__button" on:click={adicionarAoCarrinho}>
    Adicionar ao carrinho
  </button>
</div>

<style>
  .product-card {
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 16px;
    width: 250px;
  }

  @media (min-width: 1500px) {
    .product-card {
      width: 300px;
    }
    .product-card__image {
      min-height: 250px;
    }
  }

  .product-card__image {
    width: 100%;
    max-height: 200px;
    object-fit: cover;
    border-radius: 4px;
  }

  .product-card__title {
    font-size: 1.2rem;
    margin-top: 8px;
    margin-bottom: 4px;
  }

  .product-card__price {
    font-size: 1rem;
    color: var(--texto-secundario);
    margin-bottom: 8px;
  }

  .product-card__button {
    display: block;
    width: 100%;
    padding: 8px;
    font-size: 1rem;
    text-align: center;
    background-color: var(--texto-principal);
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease-in-out;
  }

  .product-card__button:hover {
    background-color: #005a86;
  }
</style>
