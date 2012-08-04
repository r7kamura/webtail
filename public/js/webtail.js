var Webtail = {
  run: function(port) {
    jQuery(function($) {
      var socket = new (WebSocket || MozWebSocket)('ws://localhost:' + port),
          body   = $('body');

      socket.onmessage = function(message) {
        $('<pre>').text(message.data).appendTo('body');
        body.trigger('onmessage');
      };
    });
  }
};
