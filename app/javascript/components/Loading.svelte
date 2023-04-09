<div class="loading">
  <div class="loading-spinner" />
</div>

<style>
  /* Estilize o container do loading */
  .loading {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
  }

  /* Estilize o spinner do loading */
  .loading-spinner {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: 3px solid #007bff; /* Cor do spinner */
    border-top-color: transparent;
    animation: loading-spinner 0.8s linear infinite;
  }

  /* Animação do spinner */
  @keyframes loading-spinner {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
</style>
