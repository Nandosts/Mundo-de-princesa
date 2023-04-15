<script lang="ts">
  import CartaoProduto from "../CartaoProduto.svelte";
  import Loading from "../Loading.svelte";

  type TProduto = {
    id: string;
    nome: string;
    descricao: string;
    preco: string;
    quantidade: number;
    imageUrl: string;
  };
  export let lista: TProduto[] = [];
  let produtos: TProduto[] = [];
  let larguraPorProduto = 250; // largura de cada Produto de cartões em pixels
  let gapEntreProdutos = 16; // espaçamento (gap) entre os produtos em pixels
  let numeroDeColunas = 3; // Número de colunas desejadas
  let produtosPorPagina = Math.ceil(
    (window.innerWidth / (larguraPorProduto + gapEntreProdutos)) *
      numeroDeColunas
  );

  let carregarMais = false;
  let mostrandoLoading = false; // Variável para controlar se o loading está sendo mostrado

  function carregarMaisProdutos() {
    mostrandoLoading = true; // Ativa o indicador de loading
    setTimeout(() => {
      const startIndex = produtos.length;
      const endIndex = startIndex + produtosPorPagina;
      if (endIndex <= lista.length) {
        produtos = [...produtos, ...lista.slice(startIndex, endIndex)];
      } else if (startIndex < lista.length && endIndex > lista.length) {
        produtos = [...produtos, ...lista.slice(startIndex)];
      }
      carregarMais = false;
      mostrandoLoading = false; // Desativa o indicador de loading
    }, 1000); // Atraso de 1 segundo (1000 milissegundos)
  }

  function verificarRolagem() {
    const alturaJanela = window.innerHeight;
    const alturaPagina = document.documentElement.scrollHeight;
    const scrollTop =
      window.pageYOffset ||
      document.documentElement.scrollTop ||
      document.body.scrollTop ||
      0;
    const margemErro = 0.9;
    const alturaParaCarregar = alturaPagina * margemErro;

    if (alturaJanela + scrollTop >= alturaParaCarregar && !carregarMais) {
      carregarMais = true;
      carregarMaisProdutos();
    }
  }

  window.addEventListener("scroll", verificarRolagem);
  if (lista && lista.length > 0) {
    produtos = lista.slice(0, produtosPorPagina);
  }
</script>

<h1>Bem-vindo ao Mundo de Princesa!</h1>
<p>Aqui estão alguns produtos incríveis para você escolher:</p>

<!-- Adicione uma div como wrapper em torno dos produtos -->
<div class="produtos-wrapper">
  <div class="grid-container">
    {#each produtos as produto}
      <div class="grid-item">
        <CartaoProduto {produto} />
      </div>
    {/each}
  </div>
</div>

{#if produtos.length === 0}
  <p>Nenhum produto encontrado.</p>
{/if}

{#if mostrandoLoading}
  <Loading />
{/if}

<style lang="scss">
  .produtos-wrapper {
    display: grid;
    margin-inline: auto;
    width: 90% !important;
  }

  .grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    grid-gap: 16px;
    margin-bottom: 16px;
  }

  @media (min-width: 1500px) {
    .grid-container {
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    }
  }

  .grid-item {
    display: flex;
    justify-content: center;
  }

  h1 {
    margin-bottom: 16px;
    color: var(--texto-principal);
  }

  p {
    margin-bottom: 16px;
    color: var(--texto-secundario);
  }
</style>
