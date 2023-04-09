<script lang="ts">
  import CartaoProduto from "../CartaoProduto.svelte";

  type TLista = {
    id: string;
    nome: string;
    descricao: string;
    preco: string;
    quantidade: number;
    imageUrl: string;
  }[];

  export let lista: TLista = [
    {
      id: "1",
      nome: "Produto 1",
      descricao: "Descrição 1",
      preco: '1000',
      quantidade: 1,
      imageUrl: "https://via.placeholder.com/150",
    },
  ];
</script>

<h1>Bem-vindo ao Mundo de Princesa!</h1>
<p>Aqui estão alguns produtos incríveis para você escolher:</p>

<div class="grid-container">
  {#each lista as produto}
    <div class="grid-item">
      <CartaoProduto {produto} />
    </div>
  {/each}
</div>

<style lang="scss">
  /* Estilize a lista de itens */
  .grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    grid-gap: 16px;
    margin-bottom: 16px;
  }

  .grid-item {
    display: flex;
    justify-content: center;
  }

  /* Estilize o cabeçalho */
  h1 {
    margin-bottom: 16px;
    color: var(--texto-principal);
  }

  /* Estilize o parágrafo */
  p {
    margin-bottom: 16px;
  }
</style>
