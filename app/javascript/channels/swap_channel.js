import consumer from "./consumer";

const initSwapCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.swapId;
    const userId = messagesContainer.dataset.userId;

    consumer.subscriptions.create({ channel: "SwapChannel", id: id }, {
      received(data) {
        var doc = new DOMParser().parseFromString(data, "text/html")
        const messageDiv = doc.getElementsByClassName("me")[0]
        if (userId != messageDiv.dataset.userId) {
          console.log("REPLACED");
          messageDiv.className = messageDiv.className.replace(/\bme\b/g, "");
        }
        // messagesContainer.insertAdjacentHTML('beforeend', );
        messagesContainer.appendChild(messageDiv);
      },
    });
  }
}

export { initSwapCable };
