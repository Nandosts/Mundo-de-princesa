const sveltePreprocess = require("svelte-preprocess");

module.exports = {
  test: /\.svelte(\.erb)?$/,
  use: [
    {
      loader: "svelte-loader",
      options: {
        hotReload: false,
        preprocess: sveltePreprocess({
          scss: {}, // Certifique-se de ter essa configuração correta
          typescript: {}, // Adicione a configuração do TypeScript aqui
        }),
      },
    },
  ],
};
