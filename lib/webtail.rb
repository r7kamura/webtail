require "socket"

require "eventmachine"
require "em-websocket"
require "sinatra/base"
require "launchy"

require "webtail/version"
require "webtail/web_socket"
require "webtail/app"
require "webtail/stdin"

module Webtail
  extend self

  def run(opts = {})
    configure(opts)

    Thread.abort_on_exception = true
    EM.run do
      EM.defer { WebSocket.run }
      EM.defer { App.run }
      EM.defer { Stdin.run }
    end
  end

  def channel
    @channel ||= EM::Channel.new
  end

  def config
    @config
  end

  private

  def configure(args)
    @config = args
  end
end
