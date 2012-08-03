var Webtail = {
  start: function(port) {
    var self = this;
    $(function() {
      self.setupWebSocket(port);
    });
  },

  setupWebSocket: function(port) {
    var ws   = this.createWebSocket('ws://localhost:' + port);
    var self = this;
    ws.onmessage = function(e) {
      var line = $('<pre/>');
      line.text(e.data);
      line.appendTo($('body'));
    };
  },

  createWebSocket: function(url) {
    if ('WebSocket' in window) {
      return new WebSocket(url);
    } else if ('MozWebSocket' in window) {
      return new MozWebSocket(url);
    }
  }
};
