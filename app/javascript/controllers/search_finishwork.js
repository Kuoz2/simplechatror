import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
    static targets = ["item"]; // Asegurar que targets está en plural
  
    filter(event) {
      const query = event.target.value.toLowerCase();
  
      this.itemTargets.forEach((item) => {
        const name = item.dataset.name || ""; // Asegurar que no sea undefined
        if (name.includes(query)) {
          item.classList.remove("hidden");
        } else {
          item.classList.add("hidden");
        }
      });
    }
  }