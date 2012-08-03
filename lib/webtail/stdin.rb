module Webtail
  module Stdin
    extend self

    def run
      STDIN.each do |line|
        Webtail.channel << strip_ansi_sequence(line)
      end
    end

    private

    def strip_ansi_sequence(str)
      str.gsub(/\e\[.*?m/, "")
    end
  end
end
