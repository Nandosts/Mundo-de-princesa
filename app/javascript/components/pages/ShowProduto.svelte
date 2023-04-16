<script lang="ts">
  import { removeItem } from "../adminProdutos";
  // Defina a estrutura do objeto do produto
  type TProduto = {
    id: string;
    nome: string;
    descricao: string;
    preco: string;
    quantidade: number;
    imageUrl: string;
    hidden?: boolean;
  };
  export let is_admin = false;
  // Crie uma variável reativa para o objeto do produto
  export let produto: TProduto = {
    id: "1",
    nome: "Produto",
    descricao: "Produto",
    preco: "99.99",
    quantidade: 1,
    imageUrl: "https://via.placeholder.com/150",
  };

  function triggerRemove(e) {
    e.preventDefault();
    const confirmResult = window.confirm(
      "Tem certeza que deseja remover o produto?"
    );
    if (confirmResult) {
      removeItem(produto);

      window.history.back();
    }
  }
</script>

<section class="produto-section">
  <!-- Conteúdo da página de exibição do produto -->
  <div class="produto-card">
    <img
      src={produto.imageUrl}
      alt={produto.nome}
      class="produto-card__image"
    />
    <div class="produto-card__content">
      {#if is_admin}
        <div class="produto-card__actions">
          <a class="edit-button" href="/produtos/{produto.id}/edit">
            <i class="fas fa-pen" />
          </a>
          <!-- svelte-ignore a11y-invalid-attribute -->
          <a class="remove-button" on:click={triggerRemove} href="#">
            <i class="fas fa-trash" />
          </a>
        </div>
      {/if}
      <h1>{produto.nome}</h1>
      <p>{produto.descricao}</p>
      <p>Preço: R$ <span>{produto.preco}</span></p>
      <p>Quantidade: <span>{produto.quantidade}</span></p>
    </div>
    <!-- Adicione mais campos do produto conforme necessário -->
  </div>
</section>

<style lang="scss">
  .produto-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    .produto-card {
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 4px;
      padding: 16px;
      width: 40%;

      position: relative;
    }

    @media (min-width: 1500px) {
      .produto-card__image {
        min-height: 250px;
      }
    }

    @media (max-width: 600px) {
      .produto-card {
        width: 100%;
      }
    }
  }

  .produto-card__image {
    width: 100%;
    object-fit: cover;
    border-radius: 4px;
    position: relative;
  }
  .produto-card__content {
    position: relative;
  }

  .produto-card__actions {
    position: absolute;
    top: 0;
    right: 0;
    border-radius: 5px;
    font-size: 1.2rem;

    a {
      color: var(--texto-principal);
    }
  }
</style>
