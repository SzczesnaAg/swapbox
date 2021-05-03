const scrollLastMessageIntoView = () => {
  const messagesElement = document.getElementById('messages');

  if (messagesElement) {
    const messages = document.querySelectorAll('.message-container');
    const lastMessage = messages[messages.length - 1];

    if (lastMessage !== undefined) {
      lastMessage.scrollIntoView();
    }
  }
};

export { scrollLastMessageIntoView };
