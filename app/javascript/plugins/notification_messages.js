const InitNotificationMessages = function () {
  const targetNode = document.getElementById('messages');

  const config = { childList: true };

  const callback = function(mutationsList, observer) {
    var AUTH_TOKEN = document.querySelector('meta[name=csrf-token]')['content'];
    const id = document.getElementById('messages').dataset.swapId;
    var url = "/swaps/" + id + "/mark_messages_as_read?&authenticity_token=" +  encodeURIComponent( AUTH_TOKEN );

    var xhr = new XMLHttpRequest();
    xhr.open("PATCH", url);
    xhr.send("");
  };

  const observer = new MutationObserver(callback);
  observer.observe(targetNode, config);
}

export { InitNotificationMessages };
