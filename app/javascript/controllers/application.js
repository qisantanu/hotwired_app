import { Application } from "@hotwired/stimulus"
import PasswordVisibility from 'stimulus-password-visibility'
import jQuery from "jquery";

const application = Application.start()
application.register('password-visibility', PasswordVisibility)

// Configure Stimulus development experience
application.debug = true
window.Stimulus   = application

// This is how the jQuery works
// You need to import like above
// And then use that instead of '$'

// jQuery('body').css('background-color', '#d63e3e');


export { application }
