import { Controller } from "@hotwired/stimulus";

 
  export default class extends Controller {
    resetComponent(event) {

      if (!event.detail || event.detail.success === false) return;
      setTimeout(() => {
        this.element.reset();
      }, 100); // 🔹 Solo resetea una vez después de 500ms
    }

    hideForm(event) {
      event.preventDefault();
      this.element.classList.add("hidden"); // Oculta el formulario
    }
  }