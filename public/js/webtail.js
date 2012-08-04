var Webtail = (function() {
  return {
    start: function(port) {
      $(function() {
        setupWebSocket(port);
      });
    }
  };

  function setupWebSocket(port) {
    var ws   = createWebSocket('ws://localhost:' + port);
    var self = this;
    ws.onmessage = function(e) {
      var line = $('<pre/>');
      line.text(e.data);
      line.appendTo($('body'));
    };
  }

  function createWebSocket(url) {
    if ('WebSocket' in window) {
      return new WebSocket(url);
    } else if ('MozWebSocket' in window) {
      return new MozWebSocket(url);
    }
  }
})();
