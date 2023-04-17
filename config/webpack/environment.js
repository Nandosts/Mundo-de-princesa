const { environment } = require("@rails/webpacker");
const svelte = require("./loaders/svelte");

environment.config.resolve = {
  conditionNames: ['webpack', 'browser', 'web', 'svelte'],
  // outras configurações
};
environment.loaders.prepend("svelte", svelte);
module.exports = environment;
