import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  // Targets
  // Targets are DOM elements used by controllers to determine the state of the page or 
  // to be changed according to the state of the page. 
  // They are identified by the attribute named data-<controller-name>-target="targetName". 
  // Stimulus defines three properties on the controller for target elements: <targetName>Target, <targetName>Targets and has<targetName>Target .
  static targets = ['params'];

  connect() {
    
  }

  // Actions 
  // connect a DOM event to the controller code that is executed when the event happens. 
  // The data-action="event->controller-name#actionName" is the attribute name that signs to Stimulus that an action is being defined.
  search() {
    const elem = this.paramsTarget;
    const value = elem.value;

    console.log('here we are serching for...', value)

    if(value.length >= 3) {
      console.log('Here we can do the form submission')
    }

    // fetch(`/notifications/lists?search_notification=${value}`, {
    //   hearders: 'Accept: text/html; turbo-stream, text/html'
    // }).then((response) => {
      
    // })
    // .then(res => {
    // })
  }
}
