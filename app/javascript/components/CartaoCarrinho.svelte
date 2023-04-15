<script lang="ts" context="module"></script>

<script lang="ts">
  export let product = {
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
      />
    </p>
    <p>
      Subtotal: R$ {(parseFloat(product.preco) * product.quantidade).toFixed(2)}
    </p>
    <div class="quantity-buttons">
      <button class="quantity-button" on:click={increaseQuantity}>+</button>
      <button class="quantity-button" on:click={decreaseQuantity}>-</button>
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
        background-color: #000;
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
      border: none;
      border-radius: 5px;
      background-color: #f8f8f8;
      color: #000;
      font-size: 1rem;

      &:focus {
        outline: none;
      }
    }
  }
</style>
