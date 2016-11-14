module LevenshteinSocNetRuby
  class Runner
    def initialize(max_words_sizes)
      LOG.warn "#{self.class.name}##{__method__} -> max_words: '#{max_words}'"
      @max_words_sizes = max_words_sizes
    end

    def run
      LOG.warn "#{self.class.name}##{__method__}"
    end
  end
end
