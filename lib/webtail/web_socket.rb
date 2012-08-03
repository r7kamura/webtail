module WebSocket
  extend self

  def run
    EM::WebSocket.start(:host => "127.0.0.1", :port => "9999") do |socket|
      socket.onopen(onopen)
      socket.onmessage(onmessage)
      socket.onerror(onerror)
    end
  end

  private

  def channel
    @channel ||= EM::Channel.new
  end

  def onopen
    lambda do
      id = channel.subscribe do |message|
        next unless message

        str = msg.respond_to?(:force_encoding) ?
          msg.force_encoding("UTF-8") :
          msg

        begin
          socket.send(str)
        rescue EM::WebSocket::WebSocketError => e
          puts e
        end
      end

      socket.onclose do
        channel.unsubscribe(id)
      end
    end
  end

  def onmessage(message)
    lambda do |message|
      channel << message
    end
  end

  def onerror(error)
    lambda do |error|
      channel << message
    end
  end
end
