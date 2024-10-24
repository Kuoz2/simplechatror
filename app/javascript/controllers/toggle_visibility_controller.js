import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  toggle() {
    this.contentTargets.forEach((element) => {
      element.classList.toggle("hidden");
    });
  }

  close(){
    this.contentTargets.forEach((element) => {
        element.classList.add("hidden")
    })
  }
}