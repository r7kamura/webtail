module WebSocket
  extend self

  LOG_SIZE = 100

  def run
    Webtail.channel.subscribe do |msg|
      logs << msg
      logs.shift if logs.size > LOG_SIZE
    end

    EM::WebSocket.start(:host => "127.0.0.1", :port => port) do |socket|
      socket.onopen(&onopen(socket))
      socket.onmessage(&onmessage)
      socket.onerror(&onerror)
    end
  end

  # return unused port
  def port
    @port ||= begin
      s = ::TCPServer.open(0)
      port = s.addr[1]
      s.close
      port
    end
  end

  private

  def logs
    @logs ||= []
  end

  def onopen(socket)
    proc do
      send_message = proc do |message|
        next unless message
        str = message.respond_to?(:force_encoding) ?
          message.force_encoding("UTF-8") :
          message

        begin
          socket.send(str)
        rescue EM::WebSocket::WebSocketError => e
          puts e
        end
      end

      logs.each(&send_message)
      id = Webtail.channel.subscribe(&send_message)

      socket.onclose do
        Webtail.channel.unsubscribe(id)
      end
    end
  end

  def onmessage
    proc do |message|
      Webtail.channel << message
    end
  end

  def onerror
    proc do |error|
      puts error
    end
  end
end
