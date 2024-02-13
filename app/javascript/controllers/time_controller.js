import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time"
export default class extends Controller {
  static values = { refreshIntervalValue: Number }

  connect() {
    console.log('Hello from Time#connect');

    if(this.hasRefreshIntervalValue) {
      console.log('here you go: ', this.hasRefreshIntervalValuel)
    }
  }
}
