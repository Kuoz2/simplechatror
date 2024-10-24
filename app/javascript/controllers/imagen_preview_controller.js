import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview"]

  preview() {
    const file = this.inputTarget.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.previewTarget.src = e.target.result;
        this.previewTarget.classList.remove("hidden");
      };
      reader.readAsDataURL(file);
    }
  }
}