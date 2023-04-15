<script lang="ts" context="module"></script>

<script lang="ts">
  import axios from "axios";
  export let product = {
    id: "",
    nome: "",
    quantidade: 0,
    preco: "0.0",
    imageUrl: "https://i.stack.imgur.com/GsDIl.jpg",
  };

  function increaseQuantity() {
    product.quantidade++;
  }

  function decreaseQuantity() {
    if (product.quantidade > 1) {
      product.quantidade--;
    }
  }

  function updateQuantity(event) {
    product.quantidade = parseInt(event.target.value) || 0;
  }

  function removeItem() {
    const csrfTokenElement = document.getElementsByName("csrf-token")[0] as
      | HTMLMetaElement
      | undefined;
    const csrfToken = csrfTokenElement?.content || "";

    // Configurar cabeçalhos da requisição
    const headers = {
      "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken,
    };
    // Faz a requisição para a rota carrinho/remove_item_do_carrinho com o ID do produto
    axios
      .post(
        "/carrinho/remove_item_do_carrinho",
        { produto: product },
        { headers }
      )
      .then((response) => {
        // Atualiza o estado do produto no carrinho após a remoção do item
        // Você pode implementar a lógica específica para atualizar o estado do carrinho aqui
        location.reload();
      })
      .catch((error) => {
        console.error("Erro ao remover item do carrinho", error);
      });
  }
</script>

<div class="product">
  <div class="product-image">
    <img src={product.imageUrl} alt="Imagem do product" />
  </div>
  <div class="product-details">
    <h3>{product.nome}</h3>
    <p>Preço: R$ {parseFloat(product.preco).toFixed(2)}</p>
    <p>
      Quantidade: <input
        type="number"
        bind:value={product.quantidade}
        on:input={updateQuantity}
        class="quantity-input"
        min="0"
      />
    </p>
    <p>
      Subtotal: R$ {(parseFloat(product.preco) * product.quantidade).toFixed(2)}
    </p>
    <div class="quantity-buttons">
      <button class="quantity-button" on:click={increaseQuantity}>+</button>
      <button class="quantity-button" on:click={decreaseQuantity}>-</button>
      <button class="remove-button" on:click={removeItem}>Remover</button>
    </div>
  </div>
</div>

<style lang="scss">
  .product {
    display: flex;
    margin-bottom: 1rem;
    padding: 1rem;
    border-radius: 5px;
    background-color: #f8f8f8;
    .product-image {
      width: 6rem;
      height: 6rem;
      overflow: hidden;
      border-radius: 5px;
    }
    .product-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .product-details {
      flex: 1;
      margin-left: 1rem;
    }
    .quantity-buttons {
      display: flex;
      gap: 0.5rem;
      .quantity-button {
        width: 2rem;
        height: 2rem;
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

    .quantity-input {
      padding: 0.5rem;
      width: 4.5rem;
      border: none;
      border-radius: 5px;
      background-color: #f8f8f8;
      color: var(--texto-secundario);
      font-size: 1rem;

      &:focus {
        outline: none;
      }
    }
  }
</style>
