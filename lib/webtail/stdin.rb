module Webtail
  module Stdin
    extend self

    ENTITY_MAP = {
      "&lt;" => "<",
      "&gt;" => ">",
    }
    ENTITY_KEYS_REGEXP = Regexp.union(ENTITY_MAP.keys)

    def run
      STDIN.each do |line|
        line = unescape_entity(line)
        line = strip_ansi_sequence(line)
        Webtail.channel << line
      end
    end

    private

    def strip_ansi_sequence(str)
      str.gsub(/\e\[.*?m/, "")
    end

    def unescape_entity(str)
      str.gsub(ENTITY_KEYS_REGEXP) {|key| ENTITY_MAP[key] }
    end
  end
end
