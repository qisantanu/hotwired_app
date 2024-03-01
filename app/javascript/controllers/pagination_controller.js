/**
 * A Stimulus controller for pagination functionality.
 * @extends Controller
 */

import { Controller } from "@hotwired/stimulus"
import $ from "jquery";
import Rails from '@rails/ujs';

// Connects to data-controller="pagination"
export default class extends Controller {
  /**
   * Indicates whether a fetch request is currently in progress.
   * @type {boolean}
   * @static
   */
  static fetching = false; // debounce

  /**
   * Defines the expected values for the controller.
   * @type {Object}
   * @static
   */
  static values = {
    url: String,
    page: { type: Number, default: 1 },
  };

  /**
   * Defines the targets that the controller can interact with.
   * @type {Array}
   * @static
   */
  static targets = ["notifications-ul", "noRecords"];

  /**
   * Binds the scroll event handler to the instance.
   * @memberof PaginationController
   * @instance
   */
  initialize() {
    this.scroll = this.scroll.bind(this);
  }

  /**
   * Connects the controller instance to the DOM.
   * @memberof PaginationController
   * @instance
   */
  connect() {
    console.log('Hello from pagination');
    document.addEventListener("scroll", this.scroll);
  }

  /**
   * Handle the scroll event to trigger the pagination.
   * @memberof PaginationController
   * @instance
   */
  scroll() {
    console.log('start scrolling')
    // check if reach end of page
    let endOfPage = this.#isItPageEnd
    let isfetching = !this.fetching

    if (endOfPage && isfetching && !this.hasNoRecordsTarget) {
      // Add the spinner at the end of the page.
      //this.postsTarget.insertAdjacentHTML("beforeend", spinner);

      let loadMoreURL = $('.load-notification a').attr('href');
      //$(".load-notification a").html('Loading...');
      console.log(loadMoreURL);

      //$.get(loadMoreURL);
      // fetch(loadMoreURL.toString() + '&scroll=true', {
      //   method: 'GET',
      //   headers: {
      //     'Accept': 'text/html;'
      //   }
      // }).then((response) => {
      //   console.log('fetch first block', response.body);
      // })
      // .then(res => {
      //   console.log('fetch last block', res);
      // })

      Rails.ajax({
        type: 'GET',
        url: loadMoreURL,
        dataType: 'json',
        success: (data) => {
          this.entriesTarget.insertAdjacentHTML('beforeend', data.entries)
          this.paginationTarget.innerHTML = data.pagination
        }
      })
    }
  }

  /**
   * Click the load more link to trigger it's related action
   * @memberof PaginationController
   * @instance
   * @private
   */
  clickLoadMore() {
    console.log('-----------0');
    $('.load-notification a').trigger('click');
    $(".load-notification a").html('Loading...');
  }

  /**
   * Sends a turbo-stream request to load more records. It will send a turbo-stream request to the controller.
   * @memberof PaginationController
   * @instance
   * @private
   */
  async #getData() {
    console.log('loading records')
    console.log(this.urlValue);
    console.log(this.pageValue);

    const url = new URL(this.urlValue);
    url.searchParams.set("page", this.pageValue);
    url.searchParams.set('append', true);
    this.fetching = true;

    // await get(url.toString(), {
    //   responseKind: "turbo-stream",
    // });

    fetch(url.toString(), {
        hearders: 'Accept: text/html; turbo-stream, text/html'
      }).then((response) => {
        console.log('fetch first block', response.body);
      })
      .then(res => {
        console.log('fetch last block', res);
      })

    this.fetching = false;
    this.pageValue += 1;
  }

  /**
   * Determines if the user has reached near the bottom of the page.
   * @memberof PaginationController
   * @instance
   * @private
   * @returns {boolean} - Indicates whether the user has reached near the bottom of the page.
   */
  get #isItPageEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    //console.log(scrollHeight - scrollTop - clientHeight);
    return scrollHeight - scrollTop - clientHeight < 50;
  }
}
