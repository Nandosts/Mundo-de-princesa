import Toastify from "toastify-js";
export function showToast(message, backgroundColor) {
  const toast = Toastify({
    text: message,
    duration: 3000,
    close: true,
    backgroundColor: backgroundColor,
    stopOnFocus: true,
  });
  toast.showToast();
}
