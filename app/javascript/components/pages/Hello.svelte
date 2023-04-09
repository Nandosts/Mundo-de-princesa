<script lang="ts">
  export let lista: string[] = [];

  // Função para remover um item da lista
  function removeItem(item: string) {
    lista = lista.filter((i) => i !== item);
  }

  // Função para tratar eventos de teclado
  function handleKeyDown(event: KeyboardEvent, item: string) {
    if (event.key === "Enter" || event.key === "Space") {
      removeItem(item);
    }
  }
</script>

<h1>Lista de Itens:</h1>
<ul>
  {#each lista as item}
    <li>
      <div class="item">{item}</div>
      <div
        class="delete-button"
        on:click={() => removeItem(item)}
        on:keydown={(event) => handleKeyDown(event, item)}
      >
        Excluir
      </div>
    </li>
  {/each}
</ul>

<style>
  /* Estilize a lista de itens */
  ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }

  li {
    padding: 8px;
    border-bottom: 1px solid #ccc;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .item {
    font-size: 18px;
  }

  .delete-button {
    cursor: pointer;
    color: #ff0000;
    margin-left: 8px;
  }

  /* Estilize o cabeçalho */
  h1 {
    margin-bottom: 16px;
  }
</style>
