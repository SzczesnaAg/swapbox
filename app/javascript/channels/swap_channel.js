import consumer from "./consumer";

const initSwapCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.swapId;

    consumer.subscriptions.create({ channel: "SwapChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initSwapCable };
