# -*- encoding: utf-8 -*-
require File.expand_path('../lib/webtail/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryo NAKAMURA"]
  gem.email         = ["r7kamura@gmail.com"]
  gem.description   = "Stdin to your browser by WebSocket"
  gem.summary       = "tail -f ... | webtail"
  gem.homepage      = "https://github.com/r7kamura/webtail"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "webtail"
  gem.require_paths = ["lib"]
  gem.version       = Webtail::VERSION

  gem.add_dependency "eventmachine"
  gem.add_dependency "em-websocket"
end
