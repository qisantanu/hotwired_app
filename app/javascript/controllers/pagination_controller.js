import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pagination"
export default class extends Controller {
  static fetching = false; // debounce

  static values = {
    url: String,
    page: { type: Number, default: 1 },
  };

  static targets = ["notifications-ul", "noRecords"];

  initialize() {
    this.scroll = this.scroll.bind(this);
  }

  connect() {
    console.log('Hello from pagination');
    document.addEventListener("scroll", this.scroll);
  }

  scroll() {
    console.log('start scrolling')
    if (this.#pageEnd && !this.fetching && !this.hasNoRecordsTarget) {
      // Add the spinner at the end of the page.
      this.postsTarget.insertAdjacentHTML("beforeend", spinner);

      this.#loadRecords();
    }
  }

  // Send a turbo-stream request to the controller.
  async #loadRecords() {
    console.log('loading records')
    const url = new URL(this.urlValue);
    url.searchParams.set("page", this.pageValue);

    this.fetching = true;

    await get(url.toString(), {
      responseKind: "turbo-stream",
    });

    this.fetching = false;
    this.pageValue += 1;
  }

  // Detect if we're at the bottom of the page.
  get #pageEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    return scrollHeight - scrollTop - clientHeight < 40;
  }
}
