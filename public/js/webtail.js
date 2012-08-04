var Webtail = {
  run: function(port) {
    var socket = new (WebSocket || MozWebSocket)('ws://localhost:' + port);
    $(function() {
      socket.onmessage = function(message) {
        $('<pre>').text(message.data).appendTo('body');
      };
    });
  }
};
