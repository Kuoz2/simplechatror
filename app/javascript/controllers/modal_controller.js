import { Controller } from '@hotwired/stimulus';


export default class extends Controller {
    static  targets = ["modal"];

    open() {
        console.log('abriendo modal');
        this.modalTarget.classList.remove("invisible", "opacity-0");
        this.modalTarget.classList.add("opacity-100");
    }
    
    close() {
        this.modalTarget.classList.add("invisible", "opacity-0");
        this.modalTarget.classList.remove("opacity-100");
    }
};