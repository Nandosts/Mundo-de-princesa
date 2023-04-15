<script lang="ts">
  import CartaoCarrinho from "../CartaoCarrinho.svelte";

  export let carrinho = []; // Array de produtos no carrinho
  let preco_total = 0;
  $: if (carrinho.length > 0) getTotalPrice();

  // Função para calcular o preço total do carrinho
  function getTotalPrice() {
    preco_total = 0;
    carrinho.forEach((product) => {
      const price = parseFloat(product.preco); // Considera a vírgula como separador decimal
      preco_total += price * product.quantidade;
    });
    return preco_total.toFixed(2); // Arredonda o resultado para 2 casas decimais
  }

  // Função de compra (a ser preenchida futuramente)
  function comprar() {
    // Implemente sua lógica de compra aqui
    // Pode usar a variável "carrinho" para obter os produtos no carrinho
    console.log("Compra realizada!");
  }
</script>

<section class="cart-section">
  {#if carrinho && carrinho.length > 0}
    <!-- Wrapper dos itens do carrinho -->
    <div class="cart-wrapper">
      <!-- Renderização dos produtos no carrinho usando o componente Product -->
      {#each carrinho as product, i}
        <CartaoCarrinho bind:product={carrinho[i]} />
      {/each}
    </div>

    <!-- Exibição do preço total do carrinho -->
    <h3>Total: R$ {preco_total.toFixed(2)}</h3>

    <!-- Botão de compra -->
    <button on:click={() => comprar()} class="btn-comprar">
      Finalizar Compra
    </button>
  {:else}
    <h3>Nenhum produto no carrinho</h3>
  {/if}
</section>

<style lang="scss">
  .cart-section {
    padding-bottom: 1rem;
    .cart-wrapper {
      max-width: 600px;
      margin: 0 auto;
    }

    .btn-comprar {
      display: block; // Transforma o botão em bloco para centralizá-lo
      margin: 1rem auto; // Centraliza o botão horizontalmente e adiciona margem superior
      font-size: 1.1rem;
      padding: 1rem 3rem;
      border: none;
      background-color: #000;
      color: #fff;
      cursor: pointer;
      border-radius: 2.5rem;
    }

    .btn-comprar:hover {
      background-color: #0056b3;
    }

    h3 {
      margin-top: 0;
      text-align: center; // Centraliza o texto
    }
  }
</style>
