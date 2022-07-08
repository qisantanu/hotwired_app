import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbomodal"
export default class extends Controller {
  connect() {
    console.log('hello from turbo modal');
  }

  submitEnd(e) {
    console.log(e.detail.success);

    if(e.detail.success) {
      this.hideModal();
    }
  }

  hideModal() {
    console.log(this.element);
    this.element.remove();
  }
}
