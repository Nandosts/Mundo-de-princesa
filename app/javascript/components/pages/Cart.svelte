<script lang="ts">
  import CartaoCarrinho from "../CartaoCarrinho.svelte";

  export let carrinho = []; // Array de produtos no carrinho
  let preco_total = 0;
  let quantidade = 1;
  $: if (carrinho.length > 0) getTotalPrice();

  // Função para calcular o preço total do carrinho
  function getTotalPrice() {
    preco_total = 0;
    carrinho.sort((a, b) => a.id - b.id);

    carrinho.forEach((product) => {
      const price = parseFloat(product.preco); // Considera a vírgula como separador decimal
      preco_total += price * quantidade;
    });
    return preco_total.toFixed(2); // Arredonda o resultado para 2 casas decimais
  }

  // Função para abrir uma nova guia com uma URL específica
  function abrirNovaGuia(link) {
    window.open(link, "_blank");
  }

  function getSaudacao() {
    const agora = new Date();
    const horaAtual = agora.getHours();

    let saudacao = "";
    if (horaAtual >= 0 && horaAtual < 12) {
      saudacao = "Bom dia";
    } else if (horaAtual >= 12 && horaAtual < 18) {
      saudacao = "Boa tarde";
    } else {
      saudacao = "Boa noite";
    }

    return saudacao;
  }

  // Função de compra (a ser preenchida futuramente)
  function comprar() {
    const saudacao = getSaudacao();
    let texto =
      saudacao +
      "! Vim fazer compras pelo seu site, gostaria de encomendar contigo os seguintes produtos:\n ";
    carrinho.forEach((product, i) => {
      if (!(quantidade > 0)) return;
      let produtoTexto =
        "\n" +
        product.nome +
        " (" +
        quantidade +
        ")" +
        ": " +
        (parseFloat(product.preco) * quantidade).toFixed(2);

      if (carrinho.length == i + 1) {
        produtoTexto =
          produtoTexto + ". \n Total: R$ " + preco_total.toFixed(2);
      } else {
        produtoTexto = produtoTexto + ",";
      }

      texto = texto + produtoTexto;
    });
    // Implemente sua lógica de compra aqui
    // Pode usar a variável "carrinho" para obter os produtos no carrinho
    const mensagemCodificada = encodeURIComponent(texto);
    const numero = process.env.NUMERO_REDIRECIONAMENTO
    const link = `https://api.whatsapp.com/send?phone=${numero}&text=${mensagemCodificada}`;
    abrirNovaGuia(link);
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
