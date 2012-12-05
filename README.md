# Webtail
Stdin to your browser by WebSocket

## Installation

```
$ gem install webtail
```

## Usage
Pass Stdout to webtail via pipeline

```
$ tail -f ... | webtail [options]
    -p, --port      port number for http server (default is 9999)
    -r, --rc        callback file location (default is ~/.webtailrc)
    -h, --help      Display this help message.
```

## ~/.webtailrc
You can define your custom callback into ~/.webtailrc.
The code in ~/.webtailrc is executed when a new line is inserted.

## Examples

### Rails log viewer

```
$ cat ~/.webtailrc
var line = $('pre:last');
var text = line.text();

if (text == '\n') {
  line.css({
    margin: '3em 0',
    height: 1,
    background: 'lime'
  });
}

if (text.match(/CACHE|Load/)) {
  line.css({
    color: '#E1017B'
  });
}

$ tail -f log/development.log | webtail
```

![](http://dl.dropbox.com/u/5978869/image/20120804_205402.png)

### Twitter client

```
$ gem install userstream
$ cat twitter.rb
# encoding: utf-8
require "user_stream"

UserStream.configure do |config|
  config.consumer_key       = "..."
  config.consumer_secret    = "..."
  config.oauth_token        = "..."
  config.oauth_token_secret = "..."
end

UserStream.client.user do |status|
  STDOUT.puts "#{status.user.name}: #{status.text}"
  STDOUT.flush
end

$ cat ~/.webtailrc
last.text(text.replace(/[ァ-ンー]{2,}/gi, 'ゆのっち'));

$ ruby twitter.rb | webtail
```

![](http://dl.dropbox.com/u/5978869/image/20120805_012055.png)
