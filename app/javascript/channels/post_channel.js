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
    postDisplay.insertAdjacentHTML('beforebegin', this.template(data))
    console.log(data)
  },

  template(data) {
    return `<article class="post">
              <div class="post-header">
                <p>${data.author.email}</p>
              </div>
              <div class="post-body">
                <p>${data.body}</p>
              </div>
            </article>`
  }
});
