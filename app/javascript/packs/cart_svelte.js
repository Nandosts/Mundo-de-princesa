// app/javascript/packs/cart_svelte.js

import Carrinho from "../components/pages/Cart.svelte";

document.addEventListener("DOMContentLoaded", () => {
  // Obtenha a lista de itens do Rails Controller, por exemplo, usando uma variável global
  const data = document.getElementById("svelte-app").dataset.cart
  const cart = JSON.parse(data);
  const app = new Carrinho({
    target: document.getElementById("svelte-app"),
    props: {
      carrinho: cart,
    },
  });

  window.app = app;
});
