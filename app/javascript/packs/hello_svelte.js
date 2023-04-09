// app/javascript/packs/hello_svelte.js

import Hello from "../components/pages/Hello.svelte";

document.addEventListener("DOMContentLoaded", () => {
  // Obtenha a lista de itens do Rails Controller, por exemplo, usando uma variável global
  const lista = JSON.parse(document.getElementById("svelte-app").dataset.lista);
  const app = new Hello({
    target: document.getElementById("svelte-app"),
    props: {
      lista: lista,
    },
  });

  window.app = app;
});
