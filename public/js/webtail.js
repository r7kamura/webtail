var Webtail = {
  run: function(port) {
    var self = this;

    jQuery(function($) {
      var socket = new (WebSocket || MozWebSocket)('ws://localhost:' + port),
          body   = $('body');

      self.onmessages.push(function(message) {
        // To ignore serial empty lines
        if (message.data == '\n' && $('pre:last').text() == '\n') return;

        // Insert a new line
        $('<pre>').text(message.data).appendTo('body');

        // Scroll to bottom of the page
        $('html, body').scrollTop($(document).height());

        // Trigger onmessage event
        body.trigger('onmessage');
      });

      socket.onmessage = function(message) {
        $.each(self.onmessages, function() { this(message) });
      };
    });
  },

  onmessages: []
};
