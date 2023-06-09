// app/javascript/packs/hello_svelte.js

import Hello from "../components/pages/Hello.svelte";

document.addEventListener("DOMContentLoaded", () => {
  // Obtenha a lista de itens do Rails Controller, por exemplo, usando uma variável global
  const dataset = document.getElementById("svelte-app").dataset;
  if (dataset) {
    const lista = JSON.parse(dataset.lista);
    const admin = JSON.parse(dataset.admin || false) ;
    const app = new Hello({
      target: document.getElementById("svelte-app"),
      props: {
        lista: lista,
        is_admin: admin,
      },
    });
    
    window.app = app;
  }
});
