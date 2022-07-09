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
      var modal = document.getElementById("modal");
      modal.style.display = "none";
    }
  }

  hideModal() {
    console.log(this.element);
    this.element.remove();
  }

  showModal() {
    console.log('shwoing modal');
    var modal = document.getElementById("modal");
    modal.style.display = "block";
  }

  closeModal() {
    console.log('hiding modal');
    var modal = document.getElementById("modal");
    modal.style.display = "none";
    this.element.remove();
  }
}
