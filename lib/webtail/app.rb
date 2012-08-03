module Webtail
  module App
    extend self

    def run
      ::Rack::Handler::WEBrick.run(
        Server.new,
        :Port          => Webtail.config[:port],
        :Logger        => ::WEBrick::Log.new("/dev/null"),
        :AccessLog     => [nil, nil],
        :StartCallback => proc { App.open_browser }
      )
    end

    def open_browser
      ::Launchy.open("http://localhost:#{Webtail.config[:port]}") rescue nil
    end

    class Server < ::Sinatra::Base
      set :root, File.expand_path("../../../", __FILE__)

      get "/" do
        @web_socket_port = WebSocket.port
        erb :index
      end
    end
  end
end
