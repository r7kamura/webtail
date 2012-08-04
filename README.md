# Webtail
Stdin to your browser by WebSocket

## Installation

```
$ gem install webtail
```

## Usage
Pass Stdout to webtail via pipeline

```
$ tail -f ... | webtail
```

## ~/.webtailrc
You can define your custom callback into ~/.webtailrc.
The code in ~/.webtailrc is executed when a new line is inserted.

Here is an example of .webtailrc:

```javascript
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
```

![](http://dl.dropbox.com/u/5978869/image/20120804_205402.png)
