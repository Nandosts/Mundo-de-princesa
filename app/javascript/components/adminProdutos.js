import { showToast } from "./flashMessage";

const csrfToken = document.getElementsByName("csrf-token")[0].content;

const headers = {
  "Content-Type": "application/json",
  "X-CSRF-Token": csrfToken,
};

export function editItem(produto) {}
export function showItem(produto) {}
export async function removeItem(produto) {
  // Exibir uma janela de confirmação
  const rota = "/produtos/" + produto.id;

  // Verificar se o usuário confirmou a remoção
  try {
    const response = await fetch(rota, {
      method: "DELETE",
      headers: headers,
    });
    if (response) {
      showToast("Produto removido com sucesso", "#009688");
    } else {
      throw new Error("Erro ao remover produto");
    }
  } catch (error) {
    showToast(`${error.message}`, "#f44336");
  }
}
