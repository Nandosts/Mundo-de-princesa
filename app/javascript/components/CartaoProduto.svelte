<script lang="ts" context="module">
  import axios from "axios";
  import { showToast } from "./flashMessage";
  import { removeItem } from "./adminProdutos";

  export type TProduto = {
    id: string;
    nome: string;
    descricao: string;
    preco: string;
    quantidade: number;
    imageUrl: string;
    hidden?: boolean;
  };
  export let id = "1";
  export let nome = "Produto";
  export let descricao = "Produto";
  export let preco = "99.99";
  export let quantidade = 1;
  export let imageUrl = "https://via.placeholder.com/150";
  export let hidden = false;
</script>

<script lang="ts">
  export let is_admin = false;
  export let produto: TProduto = {
    id: "1",
    nome: "Produto",
    descricao: "Produto",
    preco: "99.99",
    quantidade: 1,
    imageUrl: "https://via.placeholder.com/150",
    hidden: false,
  };

  function triggerRemove() {
    const confirmResult = window.confirm(
      "Tem certeza que deseja remover o produto?"
    );
    if (confirmResult) {
      produto.hidden = true;
      removeItem(produto);
    }
  }

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

{#if hidden != true}
  <div class="product-card">
    <img
      src={produto.imageUrl || imageUrl}
      alt={produto.nome || nome}
      class="product-card__image"
    />
    <div class="product-card__content">
      <h2 class="product-card__title">{produto.nome || nome}</h2>
      {#if is_admin}
        <div class="product-card__actions">
          <a class="show-button" href="/produtos/{produto.id}">
            <i class="fas fa-eye" />
          </a>
          <a class="edit-button" href="/produtos/{produto.id}/edit">
            <i class="fas fa-pen" />
          </a>
          <!-- svelte-ignore a11y-invalid-attribute -->
          <a class="remove-button" on:click={triggerRemove} href="#">
            <i class="fas fa-trash" />
          </a>
        </div>
      {/if}
      <p class="product-card__price">
        {"R$" + parseFloat(produto.preco || preco).toFixed(2)}
      </p>
      <button class="product-card__button" on:click={adicionarAoCarrinho}>
        Adicionar ao carrinho
      </button>
    </div>
  </div>
{/if}

<style lang="scss">
  .product-card {
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 16px;
    width: 250px;
    position: relative;
  }

  @media (min-width: 1500px) {
    .product-card {
      width: 300px;
    }
    .product-card__image {
      height: 250px;
    }
  }

  .product-card__image {
    width: 100%;
    height: 200px;
    object-fit: contain;
    border-radius: 4px;
    position: relative;
  }
  .product-card__content {
    position: relative;
  }
  .product-card__title {
    font-size: 1.2rem;
    margin-top: 8px;
    margin-bottom: 4px;
  }

  .product-card__actions {
    position: absolute;
    top: 0;
    right: 0;
    border-radius: 5px;
    font-size: 1.2rem;

    a {
      color: var(--texto-principal);
    }
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
