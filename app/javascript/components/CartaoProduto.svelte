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

  $: if (isNaN(produto.quantidade) || produto.quantidade == null) {
    produto.quantidade = 1;
  }
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

  function increaseQuantity() {
    produto.quantidade++;
  }

  function decreaseQuantity() {
    if (produto.quantidade > 1) {
      produto.quantidade--;
    }
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
      <div class="product-card__content__right">
        {#if is_admin}
          <div class="product-card__content__right__actions">
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

        <div class="product-card__content__right__quantidade">
          <div class="product-card__content__right__quantidade-buttons">
            <button
              class="product-card__content__right__quantidade-buttons-button"
              on:click={increaseQuantity}>+</button
            >
            <input
              type="text"
              bind:value={produto.quantidade}
              class="product-card__content__right__quantidade-buttons-input"
            />
            <button
              class="product-card__content__right__quantidade-buttons-button"
              on:click={decreaseQuantity}>-</button
            >
          </div>
        </div>
      </div>
      <div class="product-card__content__left">
        <h2 class="product-card__content__left__title">
          {produto.nome || nome}
        </h2>
        <p class="product-card__content__left__price">
          {"R$" + parseFloat(produto.preco || preco).toFixed(2)}
        </p>
      </div>
      <button
        class="product-card__content__button"
        on:click={adicionarAoCarrinho}
      >
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

    @media (min-width: 1500px) {
      width: 300px;
    }

    &__image {
      width: 100%;
      height: 200px;
      object-fit: contain;
      border-radius: 4px;
      position: relative;
    }

    &__content {
      position: relative;
      display: grid;
      grid-template-areas: "L R" "BTN BTN";
      align-items: center;

      &__left {
        grid-area: L;

        &__title {
          font-size: 1.2rem;
          margin-top: 8px;
          margin-bottom: 4px;
        }

        &__price {
          font-size: 1rem;
          color: var(--texto-secundario);
          margin-bottom: 8px;
        }
      }

      &__right {
        grid-area: R;
        margin-left: auto;

        &__actions {
          display: flex;
          justify-content: flex-end;
          align-items: center;
          column-gap: 1rem;
          border-radius: 5px;
          font-size: 1.2rem;

          a {
            color: var(--texto-principal);
          }
        }

        &__quantidade {
          &-buttons {
            &-input {
              padding: 0.2rem 0.5rem;
              width: 30%;
              border: 1px solid;
              border-radius: 5px;
              background-color: #f8f8f8;
              color: var(--texto-secundario);
              font-size: 1rem;

              &:focus {
                outline: none;
              }
            }
            display: flex;
            gap: 0.5rem;
            align-items: center;
            justify-content: flex-end;
            &-button {
              width: 1.5rem;
              height: 1.5rem;
              border: none;
              border-radius: 5px;
              background-color: var(--texto-secundario);
              color: #fff;
              font-size: 1rem;
              display: flex;
              align-items: center;
              justify-content: center;
              cursor: pointer;
              &:hover {
                background-color: #222;
              }
              &:focus {
                outline: none;
              }
            }
          }
        }
      }

      &__button {
        grid-area: BTN;
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

        &:hover {
          background-color: #005a86;
        }
      }
    }
  }
</style>
