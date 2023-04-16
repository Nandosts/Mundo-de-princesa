// app/javascript/packs/hello_svelte.js

import ShowProduto from "../components/pages/ShowProduto.svelte";

document.addEventListener("DOMContentLoaded", () => {
  // Obtenha a produto do Rails Controller, por exemplo, usando uma variável global
  const dataset = document.getElementById("svelte-app").dataset;
  if (dataset) {
    const produto = JSON.parse(dataset.produto);
    const admin = JSON.parse(dataset.admin || false) ;
    const app = new ShowProduto({
      target: document.getElementById("svelte-app"),
      props: {
        produto: produto,
        is_admin: admin,
      },
    });
    
    window.app = app;
  }
});
