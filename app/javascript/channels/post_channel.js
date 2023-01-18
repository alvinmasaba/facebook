import consumer from "./consumer"

const postChannel = consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const postDisplay = document.querySelector('#post-display')
    postDisplay.insertAdjacentHTML('afterbegin', this.template(data))
  },

  template(data) {
    return `<div class="card mb-5">
              <div class="card-body">
                <div class="d-flex flex-start align-items-center">
                  <img class="rounded-circle shadow-1-strong me-3"
                    src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(19).webp" alt="avatar" width="60"
                    height="60" />
                  <div>
                    <h6 class="fw-bold text-primary mb-1">${data.author.first_name}</h6>
                  </div>
                </div>
            
                <p class="mt-3 mb-4 pb-2">
                  ${data.body}
                </p>
            
                <div class="small d-flex justify-content-start">
                  <a href="#!" class="d-flex align-items-center me-3">
                    <i class="far fa-thumbs-up me-2"></i>
                    <p class="mb-0">Like</p>
                  </a>
                  <a href="#!" class="d-flex align-items-center me-3">
                    <i class="far fa-comment-dots me-2"></i>
                    <p class="mb-0">Comment</p>
                  </a>
                  <a href="#!" class="d-flex align-items-center me-3">
                    <i class="fas fa-share me-2"></i>
                    <p class="mb-0">Share</p>
                  </a>
                </div>
              </div>
            </div>`
  }
});
